# This depends on puppetlabs-puppet-mysql: https://github.com/puppetlabs/puppetlabs-mysql

define puphpet::mysql::db (
  $dbname,
  $user,
  $password,
  $host,
  $grant    = [],
  $sql_file = false
) {
  if ! value_true($dbname) or ! value_true($password) or ! value_true($host) {
    fail( 'DB requires that name, password and host be set. Please check your settings!' )
  }

  include ::mysql::params

  # Detect "qualified" usernames like `someuser@%` and don't automatically append the
  # specified host if one is present already.
  if $user =~ /@/ {
    $userPlusHost = $user
  } else {
    $userPlusHost = "${user}@${host}"
  }

  if ! defined(Mysql_database[$dbname]) {
    $db_resource = {
      ensure   => present,
      charset  => 'utf8',
      collate  => 'utf8_general_ci',
      provider => 'mysql',
      require  => [
        Class['::mysql::server'],
        Class['::mysql::client']
      ],
    }
    ensure_resource('mysql_database', $dbname, $db_resource)
  }

  if ! defined(Mysql_user[$user]) {
    $user_resource = {
      ensure        => present,
      password_hash => mysql_password($password),
      provider      => 'mysql',
      require       => Class['::mysql::server'],
    }
    ensure_resource('mysql_user', "${userPlusHost}", $user_resource)
  }

  $table = "${dbname}.*"

  if ! defined(Mysql_grant["${userPlusHost}/${table}"]) {
    mysql_grant { "${userPlusHost}/${table}":
      privileges => $grant,
      provider   => 'mysql',
      user       => "${userPlusHost}",
      table      => $table,
      require    => [
        Mysql_database[$dbname],
        Mysql_user["${userPlusHost}"],
        Class['::mysql::server']
      ],
    }
  }

  if $sql_file {
    exec{ "${dbname}-import":
      command     => "/usr/bin/mysql ${dbname} < ${sql_file}",
      onlyif      => "test -f ${sql_file}",
      logoutput   => true,
      environment => "HOME=${::root_home}",
      refreshonly => true,
      require     => Mysql_grant["${userPlusHost}/${table}"],
      subscribe   => Mysql_database[$dbname],
    }
  }

}
