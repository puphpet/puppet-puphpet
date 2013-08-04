# class puphpet::dotfiles
#
# copies dotfiles to vm
#
class puphpet::dotfiles (
    $match    = '^[^\.][\d\w\s].+',
    $source   = '/vagrant/files/dot/',
    $target   = '/home/vagrant/'
) {

  file { $source:
    replace => yes,
    ensure  => present,
    mode    => 0644,
    ignore  => $match,
    target  => $target
  }

}
