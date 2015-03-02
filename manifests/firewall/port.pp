# This depends on puppetlabs/firewall: https://github.com/puppetlabs/puppetlabs-firewall
# Adds a firewall rule
define puphpet::firewall::port (
  $host,
  $guest,
) {
  if ! defined(Firewall["100 tcp/${guest}"]) {
    firewall { "100 tcp/${guest}":
      port   => $guest,
      proto  => tcp,
      action => 'accept',
    }
  }
}
