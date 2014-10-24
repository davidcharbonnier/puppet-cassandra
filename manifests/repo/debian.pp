class cassandra::repo::debian(
    $repo_name,
    $location,
    $repos,
    $release,
    $key_source,
    $pin
) {
  
  exec{'add-key':
    command => '/usr/bin/wget -q https://debian.datastax.com/debian/repo_key -O - | apt-key add -',
    user    => root
  }
  
  apt::source { $repo_name:
    location          => $location,
    release           => $release,
    repos             => $repos,
    key_source        => $key_source,
    pin               => $pin,
    include_src       => false,
    require           => Exec['add-key']
  }
}
