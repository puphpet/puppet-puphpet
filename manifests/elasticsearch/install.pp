# == Class: puphpet::elasticsearch::install
#
# Installs Elasticsearch engine.
# Installs Java and opens ports
#
# Usage:
#
#  class { 'puphpet::elasticsearch::install': }
#
class puphpet::elasticsearch::install
  inherits puphpet::params
{

  $elasticsearch = $puphpet::params::hiera['elasticsearch']

  if ! defined(Puphpet::Firewall::Port['9200']) {
    puphpet::firewall::port { '9200': }
  }

  $settings = $elasticsearch['settings']

  if ! defined(Class['java']) and $settings['java_install'] {
    class { 'java':
      distribution => 'jre',
    }
  }

  if array_true($settings, 'repo_version') {
    $repo_version = $settings['repo_version']
  } else {
    $repo_version = '6.x'
  }

  $merged = delete(merge($settings, {
    'manage_repo'  => true,
    'repo_version' => "${repo_version}",
  }), ['java_install'])

  create_resources('class', { 'elasticsearch' => $merged })

  # config file could contain no instance keys
  $instances = array_true($elasticsearch, 'instances') ? {
    true    => $elasticsearch['instances'],
    default => { }
  }

  each( $instances ) |$key, $instance| {
    $name = $instance['name']

    create_resources( elasticsearch::instance, { "${name}" => $instance })
  }

}
