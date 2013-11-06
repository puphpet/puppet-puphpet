class puphpet::params {

  $xdebug_package = $::osfamily ? {
    'Debian' => 'php5-xdebug',
    'Redhat' => 'php-pecl-xdebug'
  }

  $apache_webroot_location = $::osfamily ? {
    'Debian' => '/var/www',
    'Redhat' => '/var/www/html'
  }

  $nginx_webroot_location = $::osfamily ? {
    'Debian' => '/var/www/html',
    'Redhat' => '/usr/share/nginx/html'
  }

}
