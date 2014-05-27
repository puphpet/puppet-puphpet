/*
 * This "translates" PECL package names into system-specific names.
 * For example, APCu does not install correctly on CentOS via PECL,
 * but there is a system package for it that works well. Use that
 * instead of the PECL package.
 */

define puphpet::php::pecl (
  $service_autorestart
){

  $pecl = $::osfamily ? {
    'Debian' => {
      #
    },
    'Redhat' => {
      #
    }
  }

  $package = $::osfamily ? {
    'Debian' => {
      'apc'       => $::operatingsystem ? {
        'ubuntu' => 'php5-apcu',
        'debian' => 'php5-apc',
      },
      'apcu'      => 'php5-apcu',
      'imagick'   => 'php5-imagick',
      'memcache'  => 'php5-memcache',
      'memcached' => 'php5-memcached',
      'mongo'     => 'php5-mongo',
    },
    'Redhat' => {
      'apc'       => 'php-pecl-apcu',
      'apcu'      => 'php-pecl-apcu',
      'imagick'   => 'php-pecl-imagick',
      'memcache'  => 'php-pecl-memcache',
      'memcached' => 'php-pecl-memcached',
      'mongo'     => 'php-pecl-mongo',
    }
  }

  $downcase_name = downcase($name)

  if has_key($pecl, $downcase_name) {
    $pecl_name    = $pecl[$downcase_name]
    $package_name = false
  }
  elsif has_key($package, $downcase_name) {
    $pecl_name    = false
    $package_name = $package[$downcase_name]
  }
  else {
    $pecl_name    = $name
    $package_name = false
  }

  if $pecl_name and ! defined(Php::Pecl::Module[$pecl_name]) {
    php::pecl::module { $pecl_name:
      use_package         => false,
      service_autorestart => $service_autorestart,
    }
  }
  elsif $package_name and ! defined(Package[$package_name]) {
    package { $package_name:
      ensure  => present,
      require => Class['Php::Devel'],
    }
  }

}
