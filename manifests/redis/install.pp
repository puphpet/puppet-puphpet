# Class for installing redis database
#
# If PHP is chosen for install , redis module is also installed
#
class puphpet::redis::install {

  include ::puphpet::params
  include ::redis::params

  $redis  = $puphpet::params::hiera['redis']
  $apache = $puphpet::params::hiera['apache']
  $nginx  = $puphpet::params::hiera['nginx']
  $php    = $puphpet::params::hiera['php']

  if array_true($apache, 'install') or array_true($nginx, 'install') {
    $webserver_restart = true
  } else {
    $webserver_restart = false
  }

  if array_true($redis['settings'], 'conf_port') {
    $port = $redis['settings']['conf_port']
  } else {
    $port = $redis['settings']['port']
  }

  $settings = delete(deep_merge({
    'manage_package' => true,
  }, $redis['settings']), ['conf_port', 'port', 'manage_repo'])

  if $::operatingsystem == 'ubuntu' {
    if ! defined(Apt::Key['136221EE520DDFAF0A905689B9316A7BC7917B12']) {
      ::apt::key { '136221EE520DDFAF0A905689B9316A7BC7917B12':
        server => 'hkp://keyserver.ubuntu.com:80'
      }
    }

    if ! defined(Apt::Ppa['ppa:chris-lea/redis-server']) {
      ::apt::ppa { 'ppa:chris-lea/redis-server':
        require => ::Apt::Key['136221EE520DDFAF0A905689B9316A7BC7917B12']
      }
    }
  }

  if ! defined(Group[$redis::params::default_redis_group]) {
    group { $redis::params::default_redis_group:
      ensure => present,
      before => Class['redis']
    }
  }

  if ! defined(User[$redis::params::default_redis_user]) {
    user { $redis::params::default_redis_user:
      ensure     => present,
      managehome => false,
      groups     => [$redis::params::default_redis_group],
      before     => Class['redis']
    }
  }

  if ! defined(Puphpet::Firewall::Port["${$port}"]) {
    puphpet::firewall::port { "${$port}":
      before => Class['redis'],
    }
  }

  create_resources('class', { 'redis' => $settings })

  redis::instance { $port: }

  if array_true($php, 'install') and ! defined(Puphpet::Php::Module::Pecl['redis']) {
    puphpet::php::module::pecl { 'redis':
      service_autorestart => $webserver_restart,
      require             => Class['redis']
    }
  }

}
