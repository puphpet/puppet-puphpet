# This depends on
#   puppetlabs/apt: https://github.com/puppetlabs/puppetlabs-apt
#   example42/puppet-yum: https://github.com/example42/puppet-yum

class puphpet::mariadb(
  $distro  = $::operatingsystem,
  $release = $::lsbdistcodename,
  $arch    = $::architecture,
  $version = '10.0',
  $url     = $puphpet::params::apache_mod_pagespeed_url,
  $package = $puphpet::params::apache_mod_pagespeed_package
) {

  $arch_package_name = $::architecture ? {
    'i386'   => 'x86',
    'amd64'  => 'amd64',
    'x86_64' => 'amd64'
  }

  case $::osfamily {
    'debian': {
      $os = downcase($::operatingsystem)

      apt::source { $name:
        location          => "http://mirror.jmu.edu/pub/mariadb/repo/${version}/${os}",
        release           => $release,
        repos             => 'main',
        required_packages => 'debian-keyring debian-archive-keyring',
        key               => '0xcbcb082a1bb943db',
        key_server        => 'keyserver.ubuntu.com',
        include_src       => true
      }
    }
    'centos': {
      yum::managed_yumrepo { 'MariaDB':
        descr         => 'MariaDB - mariadb.org',
        baseurl       => "http://yum.mariadb.org/${version}/centos6-${arch_package_name}",
        enabled       => 1,
        gpgcheck      => 1,
        gpgkey_source => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
        priority      => 1
      }
    }
  }
}
