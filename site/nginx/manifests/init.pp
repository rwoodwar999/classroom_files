class nginx (
  $package  = $nginx::params::package
  $owner    = $nginx::params::owner,
  $group    = $nginx::params::group,
  $docroot  = $nginx::params::docroot,
  $confdir  = $nginx::params::confdir,
  $blockdir = $nginx::params::blockdir,
  $logdir   = $nginx::params::logdir,
  $user     = $nginx::params::user,
) inherits nginx::params {
  
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
    content => epp('nginx/index.html.epp'),
  }
  
  file { 'nginx.conf':
    path   => "${confdir}/nginx.conf",
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
