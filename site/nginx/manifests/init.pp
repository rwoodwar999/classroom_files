class nginx (
  $root     = undef,
  $highperf = true,
){
  case $facts['os']['family'] {
    'redhat' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      #$docroot  = '/var/www'
      $defdocroot = '/var/www'
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
  
  $docroot = $root ? {
    undef   = $defdocroot,
    default = $root,
  }
  
  $user = $facts['os']['family'] ? {
    'redhat' => 'nginx',
    'debian' => 'nobody',
    default  => 'www',
  }
  
  file { 'docroot':
    ensure => directory,
    path   => $docroot,
  }
  
  file { 'index.html':
    path   => "${docroot}/index.html",    
    #source => 'puppet:///modules/nginx/index.html',
    content => epp('nginx/index.html.epp'),
  }
  
  file { 'nginx.conf':
    path   => "${confdir}/nginx.conf",
    #source => 'puppet:///modules/nginx/nginx.conf',
    content => epp('nginx/nginx.conf.epp', {
        user     => $user,
        confdir  => $confdir,
        blockdir => $blockdir,
        logdir   => $logdir,
        highperf => $highperf,
      }),
  }
  
  file { 'default.conf':
    path   => "${blockdir}/default.conf",
    #source => 'puppet:///modules/nginx/default.conf',
    content => epp('nginx/default.conf.epp', {
        docroot => $docroot,
      }),
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }
}
