class puphpet::mysql::server (
  $settings
){

  include puphpet::mysql::params
  include ::mysql::params

  $true_settings_no_pw = delete(deep_merge({
    'package_name'     => $puphpet::mysql::params::server_package,
    'service_name'     => $::osfamily ? {
      'RedHat' => 'mysqld',
      default  => 'mysql',
    },
    'restart'          => true,
    'override_options' => deep_merge($::mysql::params::default_options, {
      'mysqld' => {
        'user'      => 'mysql',
        'tmpdir'    => $::mysql::params::tmpdir,
        'log-error' => $::mysql::params::provider ? {
          'mariadb' => '/var/log/mysqld.log',
          default   => $::mysql::params::log_error,
        },
        'pid-file'  => $::mysql::params::provider ? {
          'mariadb' => '/var/run/mysqld/mysqld.pid',
          default   => $::mysql::params::pidfile,
        },
      },
      'mysqld_safe' => {
        'log-error' => $::mysql::params::provider ? {
          'mariadb' => '/var/log/mysqld.log',
          default   => $::mysql::params::log_error,
        },
      },
    }),
    'install_options'  => $::osfamily ? {
      'Debian' => '--force-yes',
      default  => undef,
    },
  }, $settings), ['version', 'root_password'])

  $true_settings = deep_merge({
    'root_password' => $puphpet::mysql::params::root_password
  }, $true_settings_no_pw)

  create_resources('class', {
    'mysql::server' => $true_settings
  })

}
