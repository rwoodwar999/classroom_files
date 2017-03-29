class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { 'docroot':
    ensure => directory,
    path   => '/var/www',
    owner  => 'root',
    group  => 'root',
  }
  
  file { 'index.html':
    ensure => file,
    path   => '/var/www/index.html',
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'nginx.conf':
    ensure => file,
    path   => '/etc/nginx/nginx.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { 'default.conf':
    ensure => file,
    path   => '/etc/nginx/conf.d/default.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['nginx.conf'], 
    subscribe => File['default.conf'],
  }
}
