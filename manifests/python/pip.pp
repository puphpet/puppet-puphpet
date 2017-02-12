class puphpet::python::pip {

  include ::puphpet::python::params

  Exec { path => [
    '/usr/bin/',
    '/usr/local/bin',
    '/bin',
    '/usr/local/sbin',
    '/usr/sbin',
    '/sbin'
  ] }

  puphpet::server::wget { $puphpet::python::params::setup_tools_download:
    source => $puphpet::python::params::setup_tools_url,
    user   => 'root',
    group  => 'root',
  }
  -> exec { 'easy_install pip':
    command => "python ${puphpet::python::params::setup_tools_download}",
    creates => '/usr/local/bin/pip',
    unless => 'which pip',
  }

  if $::osfamily == 'RedHat' {
    exec { 'rhel pip_provider_name_fix':
      command   => 'alternatives --install /usr/bin/pip-python pip-python /usr/bin/pip 1',
      subscribe => Exec['easy_install pip'],
      unless    => 'which pip-python',
    }
  }

}
