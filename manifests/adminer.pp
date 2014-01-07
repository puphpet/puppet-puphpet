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
    command => "wget http://www.adminer.org/latest.php -o ${location}/index.php",
    require => File[$location],
    returns => [4],
  }

}
