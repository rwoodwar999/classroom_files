class nginx (
  String $root = undef,
  Boolean $highperf = true,
  ) {
  case $facts['os']['family'] {
    'redhat','debian' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
   #   $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d' 
      $logdir   = '/var/log/nginx'
      $svcname  = 'nginx'
      $runsas   = 'nginx'
    }
    default : {
      fail("Module ${module_name} is not supported on ${facts['os']['family']}")
    }
  }
 $user = 'nginx'
 
 # if $root isn't set, then fall back to the platform default
  $docroot = $root ? {
    undef => $default_docroot,
    default => $root,
    }
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }
  package { $package:
    ensure => present,
  }
  file { $docroot:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    #source => 'puppet:///modules/nginx/index.html',
    content => epp('nginx/index.html.epp'),
  }
  file { "${confdir}/nginx.conf":
    ensure => file,
  #  source => "puppet:///modules/nginx/${facts['os']['family']}.conf",
     content => epp('nginx/nginx.conf.epp',
      {
        user => $user,
        logdir => $logdir,
        confdir => $confdir,
        blockdir => $blockdir,
      }),
    require => Package[$package],
    notify => Service['nginx'],
  }
  file { "${blockdir}/default.conf":
    ensure => file,
   # source => "puppet:///modules/nginx/default-${facts['kernel']}.conf",
    content => epp('nginx/default.conf.epp',{
            docroot => $docroot,
           }),

    require => Package[$package],
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
