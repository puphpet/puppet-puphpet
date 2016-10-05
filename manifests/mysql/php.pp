class puphpet::mysql::php
 inherits puphpet::mysql::params {

  include puphpet::php::params

  $mysql = $puphpet::params::hiera['mysql']
  $php   = $puphpet::params::hiera['php']
  $hhvm  = $puphpet::params::hiera['hhvm']

  if array_true($php, 'install') {
    $php_package = 'php'
  } elsif array_true($hhvm, 'install') {
    $php_package = 'hhvm'
  } else {
    $php_package = false
  }

  if $php_package == 'php' {
    if $::osfamily == 'redhat' {
      $php_module = 'mysqlnd'
    } else {
      # php5.5-mysql
      $php_module = "php${puphpet::php::params::version_match}-mysql"
    }

    if ! defined(Puphpet::Php::Module::Package[$php_module]) {
      puphpet::php::module::package { $php_module:
        service_autorestart => true,
      }
    }
  }

  if array_true($mysql, 'adminer')
    and $php_package
    and ! defined(Class['puphpet::adminer::install'])
  {
    class { 'puphpet::adminer::install': }
  }

}
