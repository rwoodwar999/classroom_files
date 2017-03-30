class nginx::services {
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }
}
