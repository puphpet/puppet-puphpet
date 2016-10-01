class puphpet::php::params
  inherits ::puphpet::params
{

  $version = $hiera['php']['settings']['version']

  $enable_modules = true
  $enable_pear    = true
  $enable_pecl    = true
  $enable_xdebug  = true

  $version_match = to_string($version) ? {
    /5\.5/    => '5.5',
    /5\.5\.*/ => '5.5',
    /55/      => '5.5',
    /55.*/    => '5.5',

    /5\.6/    => '5.6',
    /5\.6\.*/ => '5.6',
    /56/      => '5.6',
    /56.*/    => '5.6',

    /7\.0/    => '7.0',
    /7\.0\.*/ => '7.0',
    /70/      => '7.0',
    /70.*/    => '7.0',

    /7\.1/    => '7.1',
    /7\.1\.*/ => '7.1',
    /71/      => '7.1',
    /71.*/    => '7.1',

    default   => undef,
  }

  $version_int = to_string($version) ? {
    /5\.5/    => '55',
    /5\.5\.*/ => '55',
    /55/      => '55',
    /55.*/    => '55',

    /5\.6/    => '56',
    /5\.6\.*/ => '56',
    /56/      => '56',
    /56.*/    => '56',

    /7\.0/    => '70',
    /7\.0\.*/ => '70',
    /70/      => '70',
    /70.*/    => '70',

    /7\.1/    => '71',
    /7\.1\.*/ => '71',
    /71/      => '71',
    /71.*/    => '71',

    default   => undef,
  }

  if $version_match == '7.1' {
    $prefix      = 'php-'
    $pecl_prefix = $::osfamily ? {
      'debian' => 'php-',
      'redhat' => 'php-pecl-',
    }

    $cli_package = $::osfamily ? {
      'debian' => 'php7.1-cli',
      'redhat' => 'php-cli',
    }

    $fpm_package = $::osfamily ? {
      'debian' => 'php7.1-fpm',
      'redhat' => 'php-fpm',
    }

    $service = $fpm_package

    $package_devel = $::osfamily ? {
      'debian' => 'php7.1-dev',
      'redhat' => 'php-devel',
    }

    $root_ini = $::osfamily ? {
      'debian' => '/etc/php/7.1/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $fpm_ini = $::osfamily ? {
      'debian' => '/etc/php/7.1/fpm/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $pid_file = $::osfamily ? {
      'debian' => '/run/php-fpm.pid',
      'redhat' => '/var/run/php-fpm.pid',
    }

    $bin = $::osfamily ? {
      'debian' => '/usr/bin/php7.1',
      'redhat' => '/usr/bin/php',
    }
  }

  if $version_match == '7.0' {
    $prefix      = 'php-'
    $pecl_prefix = $::osfamily ? {
      'debian' => 'php-',
      'redhat' => 'php-pecl-',
    }

    $cli_package = $::osfamily ? {
      'debian' => 'php7.0-cli',
      'redhat' => 'php-cli',
    }

    $fpm_package = $::osfamily ? {
      'debian' => 'php7.0-fpm',
      'redhat' => 'php-fpm',
    }

    $service = $fpm_package

    $package_devel = $::osfamily ? {
      'debian' => 'php7.0-dev',
      'redhat' => 'php-devel',
    }

    $root_ini = $::osfamily ? {
      'debian' => '/etc/php/7.0/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $fpm_ini = $::osfamily ? {
      'debian' => '/etc/php/7.0/fpm/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $pid_file = $::osfamily ? {
      'debian' => '/run/php-fpm.pid',
      'redhat' => '/var/run/php-fpm.pid',
    }

    $bin = $::osfamily ? {
      'debian' => '/usr/bin/php7.0',
      'redhat' => '/usr/bin/php',
    }
  }

  if $version_match == '5.6' {
    $prefix      = 'php-'
    $pecl_prefix = $::osfamily ? {
      'debian' => 'php-',
      'redhat' => 'php-pecl-',
    }

    $cli_package = $::osfamily ? {
      'debian' => 'php5.6-cli',
      'redhat' => 'php-cli',
    }

    $fpm_package = $::osfamily ? {
      'debian' => 'php5.6-fpm',
      'redhat' => 'php-fpm',
    }

    $service = $fpm_package

    $package_devel = $::osfamily ? {
      'debian' => 'php5.6-dev',
      'redhat' => 'php-devel',
    }

    $root_ini = $::osfamily ? {
      'debian' => '/etc/php/5.6/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $fpm_ini = $::osfamily ? {
      'debian' => '/etc/php/5.6/fpm/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $pid_file = $::osfamily ? {
      'debian' => '/run/php-fpm.pid',
      'redhat' => '/var/run/php-fpm.pid',
    }

    $bin = $::osfamily ? {
      'debian' => '/usr/bin/php5.6',
      'redhat' => '/usr/bin/php',
    }
  }

  if $version_match == '5.5' {
    $prefix      = 'php-'
    $pecl_prefix = $::osfamily ? {
      'debian' => 'php-',
      'redhat' => 'php-pecl-',
    }

    $cli_package = $::osfamily ? {
      'debian' => 'php5.5-cli',
      'redhat' => 'php-cli',
    }

    $fpm_package = $::osfamily ? {
      'debian' => 'php5.5-fpm',
      'redhat' => 'php-fpm',
    }

    $service = $fpm_package

    $package_devel = $::osfamily ? {
      'debian' => 'php5.5-dev',
      'redhat' => 'php-devel',
    }

    $root_ini = $::osfamily ? {
      'debian' => '/etc/php/5.5/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $fpm_ini = $::osfamily ? {
      'debian' => '/etc/php/5.5/fpm/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $pid_file = $::osfamily ? {
      'debian' => '/run/php-fpm.pid',
      'redhat' => '/var/run/php-fpm.pid',
    }

    $bin = $::osfamily ? {
      'debian' => '/usr/bin/php5.5',
      'redhat' => '/usr/bin/php',
    }
  }

  Package[$fpm_package]
  -> Puphpet::Php::Module::Package <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Module::Pear <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Module::Pecl <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Ini <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Fpm::Ini <| |>

  Package[$fpm_package]
  -> Puphpet::Php::Fpm::Pool_ini <| |>

}
