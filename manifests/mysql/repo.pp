class puphpet::mysql::repo(
  $version
) {

  if ! ($version in ['55', '5.5', '56', '5.6']) {
    fail ( 'puphpet::mysql::repo only supports MySQL version 5.5 and 5.6' )
  }

  if $version in ['55', '5.5'] {
    case $::operatingsystem {
      'debian': {
        if ! defined(Apt::Source['packages.dotdeb.org-repo.puphpet']) {
          apt::source { 'packages.dotdeb.org-repo.puphpet':
            location          => 'http://repo.puphpet.com/dotdeb/',
            release           => $::lsbdistcodename,
            repos             => 'all',
            required_packages => 'debian-keyring debian-archive-keyring',
            key               => '89DF5277',
            key_server        => 'hkp://keyserver.ubuntu.com:80',
            include_src       => true
          }
        }
      }
      'ubuntu': {
        if ! defined(Apt::Key['E5267A6C']){
          apt::key { 'E5267A6C':
            key_server => 'hkp://keyserver.ubuntu.com:80'
          }
        }

        if $::lsbdistcodename in ['lucid', 'precise'] {
          apt::ppa { 'ppa:ondrej/mysql-5.5':
            require => Apt::Key['E5267A6C'],
            options => ''
          }
        } else {
          apt::ppa { 'ppa:ondrej/mysql-5.5':
            require => Apt::Key['E5267A6C']
          }
        }
      }
      'redhat', 'centos': {
        $rhel_mysql = 'http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm'

        $mysql_rhel_yum   = "yum -y --nogpgcheck install '${rhel_mysql}'"
        $mysql_rhel_touch = 'touch /.puphpet-stuff/mysql-community-release'

        exec { 'mysql-community-repo':
          command => "${mysql_rhel_yum} && ${mysql_rhel_touch}",
          creates => '/.puphpet-stuff/mysql-community-release'
        }
      }
    }
  }

  if $version in ['56', '5.6'] {
    case $::operatingsystem {
      'debian': {
        if ! defined(Apt::Source['packages.dotdeb.org-repo.puphpet']) {
          apt::source { 'packages.dotdeb.org-repo.puphpet':
            location          => 'http://repo.puphpet.com/dotdeb/',
            release           => $::lsbdistcodename,
            repos             => 'all',
            required_packages => 'debian-keyring debian-archive-keyring',
            key               => '89DF5277',
            key_server        => 'hkp://keyserver.ubuntu.com:80',
            include_src       => true
          }
        }
      }
      'ubuntu': {
        if ! defined(Apt::Key['E5267A6C']){
          apt::key { 'E5267A6C':
            key_server => 'hkp://keyserver.ubuntu.com:80'
          }
        }

        if $::lsbdistcodename in ['lucid', 'precise'] {
          apt::ppa { 'ppa:ondrej/mysql-5.6':
            require => Apt::Key['E5267A6C'],
            options => ''
          }
        } else {
          apt::ppa { 'ppa:ondrej/mysql-5.6':
            require => Apt::Key['E5267A6C']
          }
        }
      }
      'redhat', 'centos': {
        $rhel_mysql = 'http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm'

        $mysql_rhel_yum   = "yum -y --nogpgcheck install '${rhel_mysql}'"
        $mysql_rhel_touch = 'touch /.puphpet-stuff/mysql-community-release'

        exec { 'mysql-community-repo':
          command => "${mysql_rhel_yum} && ${mysql_rhel_touch}",
          creates => '/.puphpet-stuff/mysql-community-release'
        }
      }
    }
  }

}
