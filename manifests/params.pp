class puphpet::params (
  $extra_config_files = []
) {

  $puphpet_core_dir  = pick(getvar('::puphpet_core_dir'), '/opt/puphpet')
  $puphpet_state_dir = pick(getvar('::puphpet_state_dir'), '/opt/puphpet-state')
  $ssh_username      = pick(getvar('::ssh_username'), 'root')
  $provisioner_type  = pick(getvar('::provisioner_type'), 'remote')

  $puphpet_manifest_dir = "${puphpet_core_dir}/puppet/modules/puphpet"

  $base_configs = [
    "${puphpet_core_dir}/config.yaml",
    "${puphpet_core_dir}/config-${provisioner_type}.yaml",
  ]

  $custom_config = ["${puphpet_core_dir}/config-custom.yaml"]

  $yaml = merge_yaml($base_configs, $extra_config_files, $custom_config)

  $hiera = {
    vm             => lookup('vagrantfile', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    apache         => $yaml['apache'],
    beanstalkd     => lookup('beanstalkd', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    blackfire      => lookup('blackfire', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    cron           => lookup('cron', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    drush          => lookup('drush', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    elasticsearch  => lookup('elastic_search', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    firewall       => lookup('firewall', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    hhvm           => lookup('hhvm', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    letsencrypt    => lookup('letsencrypt', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    locales        => lookup('locale', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    mailhog        => lookup('mailhog', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    mariadb        => lookup('mariadb', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    mongodb        => lookup('mongodb', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    mysql          => lookup('mysql', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    nginx          => $yaml['nginx'],
    nodejs         => lookup('nodejs', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    php            => lookup('php', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    postgresql     => lookup('postgresql', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    python         => lookup('python', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    rabbitmq       => lookup('rabbitmq', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    redis          => lookup('redis', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    resolv         => lookup('resolv', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    ruby           => lookup('ruby', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    server         => lookup('server', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    solr           => lookup('solr', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    sqlite         => lookup('sqlite', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    users_groups   => lookup('users_groups', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    wpcli          => lookup('wpcli', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    xdebug         => lookup('xdebug', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
    xhprof         => lookup('xhprof', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, {}),
  }

}
