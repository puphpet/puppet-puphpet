define puphpet::php::module::package (
  $prefix = $puphpet::php::params::prefix,
  $service_autorestart
){

  include puphpet::php::params

  $package_name = downcase($name)

  if ! defined(Php::Module[$package_name])
    and $puphpet::php::params::enable_modules
  {
    ::php::module { $package_name:
      service_autorestart => $service_autorestart,
      module_prefix       => $prefix,
    }
  }

}
