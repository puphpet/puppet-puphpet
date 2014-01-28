# This depends on
#   puppetlabs/apt: https://github.com/puppetlabs/puppetlabs-apt
#   example42/puppet-yum: https://github.com/example42/puppet-yum

class puphpet::hhvm(
  $nightly = false
) {

  $package_name = $nightly ? {
    true => $puphpet::params::hhvm_package_name_nightly,
    default => $puphpet::params::hhvm_package_name
  }

  case $::osfamily {
    'debian': {
      $os = downcase($::operatingsystem)

      apt::key { 'hhvm':
        key        => '16d09fb4',
        key_source => 'http://dl.hhvm.com/conf/hhvm.gpg.key',
      }

      apt::source { 'hhvm':
        location          => "http://dl.hhvm.com/debian ${os}",
        repos             => 'main',
        required_packages => 'debian-keyring debian-archive-keyring',
        key               => '16d09fb4',
        include_src       => true,
        require           => Apt::Key['hhvm']
      }
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

  ensure_packages( [$package_name] )

}
