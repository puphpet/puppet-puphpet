class puphpet::mysql::params {

  $mysql_server_55 = $::osfamily ? {
    'debian' => 'mysql-server-5.5',
    'redhat' => 'mysql55-server',
  }

  $mysql_client_55 = $::osfamily ? {
    'debian' => 'mysql-client-5.5',
    'redhat' => 'mysql55',
  }

  $mysql_server_56 = $::osfamily ? {
    'debian' => 'mysql-server-5.6',
    'redhat' => 'mysql56u-server',
  }

  $mysql_client_56 = $::osfamily ? {
    'debian' => 'mysql-client-5.6',
    'redhat' => 'mysql56u',
  }

}
