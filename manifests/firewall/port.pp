# This depends on puppetlabs/firewall: https://github.com/puppetlabs/puppetlabs-firewall
# Adds a firewall rule
define puphpet::firewall::port (
  $port,
  $protocol = tcp,
  $action   = 'accept',
  $priority = 100,
) {
  $rule_name = "${rule['priority']} ${rule['proto']}/${rule['port']}"

  if ! defined(Firewall["100 tcp/${guest}"]) {
    firewall { "100 tcp/${guest}":
      port   => $guest,
      proto  => tcp,
      action => 'accept',
    }
  }
}
