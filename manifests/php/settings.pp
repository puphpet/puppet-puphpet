class puphpet::php::settings (
  $version
){

  if $version == '7.0' or $version == '70' {
    $enable_modules = false
    $enable_pear    = false
    $enable_pecl    = false
    $enable_xdebug  = false

    $php_prefix = $::osfamily ? {
      'debian' => 'php7-',
      'redhat' => 'php-',
    }

    $php_fpm_ini = $::osfamily ? {
      'debian' => '/etc/php7/fpm/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $config_file = $::operatingsystem ? {
      /(?i:Ubuntu|Debian|Mint)/ => '/etc/php7/php.ini',
      default                   => '/etc/php.ini',
    }

    $php_module_prefix = $::operatingsystem ? {
      /(?i:Ubuntu|Debian|Mint|SLES|OpenSuSE)/ => 'php7-',
      default                                 => 'php-',
    }
  } else {
    $enable_modules = true
    $enable_pear    = true
    $enable_pecl    = true
    $enable_xdebug  = true

    $php_prefix = $::osfamily ? {
      'debian' => 'php5-',
      'redhat' => 'php-',
    }

    $php_fpm_ini = $::osfamily ? {
      'debian' => '/etc/php5/fpm/php.ini',
      'redhat' => '/etc/php.ini',
    }

    $config_file = $::operatingsystem ? {
      /(?i:Ubuntu|Debian|Mint)/ => '/etc/php5/php.ini',
      default                   => '/etc/php.ini',
    }

    $php_module_prefix = $::operatingsystem ? {
      /(?i:Ubuntu|Debian|Mint|SLES|OpenSuSE)/ => 'php5-',
      default                                 => 'php-',
    }
  }

  $cli_package = "${php_prefix}cli"
  $fpm_package = "${php_prefix}fpm"

}
