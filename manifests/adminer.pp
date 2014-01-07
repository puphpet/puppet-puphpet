class puphpet::adminer(
  $location,
  $owner = 'www-data'
) {

  if ! defined(File[$location]) {
    file { $location:
      replace => no,
      ensure  => directory,
      mode    => 775,
      require => Package['php']
    }
  }

  exec{ "download adminer to ${location}":
    command => "wget -O ${location}/index.php http://www.adminer.org/latest.php",
    require => File[$location],
    returns => [4],
  }

}
