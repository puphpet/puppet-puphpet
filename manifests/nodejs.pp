# This depends on
#   puppetlabs/apt: https://github.com/puppetlabs/puppetlabs-apt
#   example42/puppet-yum: https://github.com/example42/puppet-yum

class puphpet::nodejs {

  file { '/.puphpet-stuff/node_install.sh':
    ensure  => present,
    owner   => root,
    mode    => 0755,
    content => template("${module_name}/nodejs/install.erb"),
  }
  -> exec { 'install-node':
    command => '/.puphpet-stuff/node_install.sh',
    creates => '/usr/bin/node',
  }

}
