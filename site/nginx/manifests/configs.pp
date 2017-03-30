class nginx::configs {
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
}
