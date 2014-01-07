class puphpet::params {

  $xdebug_package = $::osfamily ? {
    'Debian' => 'php5-xdebug',
    'Redhat' => 'php-pecl-xdebug'
  }

  $apache_webroot_location = $::osfamily ? {
    'Debian' => '/var/www',
    'Redhat' => '/var/www/html'
  }

  $apache_mod_pagespeed_url = $::osfamily ? {
    'Debian' => $::architecture ? {
        'i386'   => 'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_i386.deb',
        'amd64'  => 'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb',
        'x86_64' => 'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb'
      },
    'Redhat' => $::architecture ? {
        'i386'   => 'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_i386.rpm',
        'amd64'  => 'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm'
        'x86_64' => 'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm'
      },
  }

  $apache_mod_pagespeed_package = 'mod-pagespeed-stable'

  $nginx_webroot_location = $::osfamily ? {
    'Debian' => '/var/www/html',
    'Redhat' => '/usr/share/nginx/html'
  }

}
