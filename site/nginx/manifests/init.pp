class nginx {
  case $facts['os']['family'] {
    'redhat','debian' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
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
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
    ensure => file,
    source => "puppet:///modules/nginx/${facts['os']['family']}.conf",
    require => Package[$package],
    notify => Service['nginx'],
  }
  file { "${blockdir}/default.conf":
    ensure => file,
    source => "puppet:///modules/nginx/default-${facts['kernel']}.conf",
    require => Package[$package],
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
