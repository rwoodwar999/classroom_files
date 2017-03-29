class nginx {
  package { 'nginx':
  ensure => present,
  }

file { '/var/www':
  ensure => directory,
  owner => 'root',
  group => 'root',
  mode => '0775', 
  }

file { '/var/www/index.html':
  ensure => file,
  owner => 'root',
  group => 'root',
  mode => '0664', # allow Puppet to re-write files as needed on Windows
  source => 'puppet:///modules/nginx/index.html',
  }
}
