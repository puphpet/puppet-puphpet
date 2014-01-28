# This depends on
#   puppetlabs/apt: https://github.com/puppetlabs/puppetlabs-apt
#   example42/puppet-yum: https://github.com/example42/puppet-yum

class puphpet::hhvm(
  $nightly = false
) {

  $package_name_base = $nightly ? {
    true => $puphpet::params::hhvm_package_name_nightly,
    default => $puphpet::params::hhvm_package_name
  }

  $hhvm_package_name_fcgi = $puphpet::params::hhvm_package_name_fcgi

  case $::operatingsystem {
    'debian': {
      if $::lsbdistcodename != 'wheezy' {
        error('Sorry, HHVM currently only works with Debian 7+.')
      }

      $sources_list = '/etc/apt/sources.list'

      $deb_srcs = [
        'deb http://http.us.debian.org/debian wheezy main',
        'deb-src http://http.us.debian.org/debian wheezy main',
        'deb http://security.debian.org/ wheezy/updates main',
        'deb-src http://security.debian.org/ wheezy/updates main',
        'deb http://http.us.debian.org/debian wheezy-updates main',
        'deb-src http://http.us.debian.org/debian wheezy-updates main'
      ]

      each( $deb_srcs ) |$value| {
        exec { "add non-free to ${value}":
          cwd     => '/etc/apt',
          command => "perl -p -i -e 's#${value}#${value} non-free#gi' ${sources_list}",
          unless  => "grep -Fxq '${value} non-free' ${sources_list}",
          path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
          notify  => Exec['apt_update']
        }
      }

      class { 'apache::mod::fastcgi': }
    }
    'centos': {
      yum::managed_yumrepo { 'hop5 repository':
        descr    => 'hop5 repository',
        baseurl  => 'http://www.hop5.in/yum/el6/hop5.repo',
        enabled  => 1,
        gpgcheck => 0,
        priority => 1
      }
    }
  }

  $os = downcase($::operatingsystem)

  case $::osfamily {
    'debian': {
      apt::key { 'hhvm':
        key        => '16d09fb4',
        key_source => 'http://dl.hhvm.com/conf/hhvm.gpg.key',
      }

      apt::source { 'hhvm':
        location          => "http://dl.hhvm.com/${os}",
        repos             => 'main',
        required_packages => 'debian-keyring debian-archive-keyring',
        include_src       => false,
        require           => Apt::Key['hhvm']
      }
    }
  }

  ensure_packages( [ $package_name_base, $hhvm_package_name_fcgi ] )

}
