class puphpet::xdebug (
  $install_cli = true,
  $webserver,
  $ensure = present
) inherits puphpet::params {

  if defined(Package[$puphpet::params::xdebug_package]) == false {
    package { 'xdebug':
      name    => $puphpet::params::xdebug_package,
      ensure  => installed,
      require => Package['php'],
      notify  => Service[$webserver],
    }
  }

  # shortcut for xdebug CLI debugging
  if $install_cli and defined(File['/usr/bin/xdebug']) == false {
    file { '/usr/bin/xdebug':
      ensure  => present,
      mode    => '+X',
      source  => 'puppet:///modules/puphpet/xdebug_cli_alias.erb',
      require => Package['php']
    }
  }

}
