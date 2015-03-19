class puphpet::mysql::params {

  $mysql_server_55 = $::operatingsystem ? {
    'debian' => 'mysql-server-5.5',
    'ubuntu' => 'mysql-server-5.5',
    'Redhat' => 'mysql55-mysql-server',
  }

  $mysql_client_55 = $::operatingsystem ? {
    'debian' => 'mysql-client-5.5',
    'ubuntu' => 'mysql-client-5.5',
    'Redhat' => 'mysql55-mysql',
  }

  $mysql_server_56 = $::operatingsystem ? {
    'debian' => 'mysql-server-5.6',
    'ubuntu' => 'mysql-server-5.6',
    'Redhat' => 'mysql-community-server',
  }

  $mysql_client_56 = $::operatingsystem ? {
    'debian' => 'mysql-client-5.6',
    'ubuntu' => 'mysql-client-5.6',
    'Redhat' => 'mysql-community-client',
  }

}
