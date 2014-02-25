class puphpet::xhprof (
  $php_version      = '54',
  $webroot_location = '/var/www',
  $webserver_service
) inherits puphpet::params {

  if $::operatingsystem == 'ubuntu' and $php_version == '54' {
    exec { 'pecl bundle xhprof':
      cwd     => '/tmp',
      creates => $webroot_location,
      path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
      require => Package['php5-dev'],
      onlyif  => "test -d ${webroot_location}/xhprof"
    }

    exec { 'configure xhprof':
      cwd     => '/tmp/xhprof/extension',
      command => 'phpize && ./configure && make && make install',
      require => Exec['pecl bundle xhprof']
    }

    puphpet::ini { 'add xhprof ini extension':
      php_version  => $php_version,
      webserver    => $webserver,
      ini_filename => '20-xhprof-custom.ini',
      entry        => 'XHPROF/extension',
      value        => 'xhprof.so',
      ensure       => 'present',
      require      => Exec['configure xhprof']
    }

    puphpet::ini { 'add xhprof ini xhprof.output_dir':
      php_version  => $php_version,
      webserver    => $webserver,
      ini_filename => '20-xhprof-custom.ini',
      entry        => 'XHPROF/xhprof.output_dir',
      value        => '/tmp',
      ensure       => 'present',
      require      => Exec['configure xhprof']
    }
  } elsif $::operatingsystem == 'ubuntu' and $php_version == '55' {
    if ! defined(Package['php5-xhprof']) {
      package { 'php5-xhprof':
        ensure  => installed,
        require => Package['php'],
        notify  => $webserver_service,
      }
    }
  }

}
