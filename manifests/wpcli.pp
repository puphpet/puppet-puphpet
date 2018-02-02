# Class for installing WP CLI tool
#
# PHP and Composer must be selected for install
#
class puphpet::wpcli {

  include ::puphpet::params

  $wpcli = $puphpet::params::hiera['wpcli']
  $php   = $puphpet::params::hiera['php']

  $version  = $wpcli['version'] != undef
  $engine   = array_true($php, 'install')
  $composer = array_true($php, 'composer')

  # Requires either PHP and Composer
  if $version and $engine and $composer {
    class { 'puphpet::wpcli::install' :
      version => $wpcli['version']
    }
  }

}
