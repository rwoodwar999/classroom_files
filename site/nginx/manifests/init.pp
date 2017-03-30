class nginx {
  case $facts['os']['family'] {
    'redhat' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir   = '/var/log/nginx'
    }
    default : {
      fail("${module_name} is not supported on ${facts['os']['family']}")
    }
  }

  package { $package:
    ensure => present,
  }
  
  File {
    ensure => file,
    owner  => $owner,
    group  => $group,
    mode   => '0644',
  }
  
  file { 'docroot':
    ensure => directory,
    path   => $docroot,
  }
  
  file { 'index.html':
    path   => "${docroot}/index.html",    
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'nginx.conf':
    path   => "${confdir}/nginx.conf",
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { 'default.conf':
    path   => "${blockdir}/default.conf",
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }
}
