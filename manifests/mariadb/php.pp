class puphpet::mariadb::php
 inherits puphpet::mariadb::params {

  $mariadb = $puphpet::params::hiera['mariadb']
  $php     = $puphpet::params::hiera['php']
  $hhvm    = $puphpet::params::hiera['hhvm']

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
      $php_module = 'mysql'
    }

    if ! defined(Puphpet::Php::Module::Package[$php_module]) {
      puphpet::php::module::package { $php_module:
        service_autorestart => true,
      }
    }
  }

  if array_true($mariadb, 'adminer')
    and $php_package
    and ! defined(Class['puphpet::adminer::install'])
  {
    class { 'puphpet::adminer::install': }
  }

}
