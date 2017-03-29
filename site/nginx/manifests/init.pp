class nginx {
  package { 'nginx':
  ensure => present,
  }

file { 'docroot':
    ensure => directory,
    path =>  '/var/www',
    owner => '/root',
    group => 'root',
    }

file { '/index.html':
  ensure => file,
  path  =>  '/var/www/index.html',
  owner => 'root',
  group => 'root',
  mode => '0664', # allow Puppet to re-write files as needed on Windows
  source => 'puppet:///modules/nginx/index.html',
  }
  file {'ngix.conf':
  {
    ensure => file,
    path  =>  '/var/www/ngix.conf',
    owner => 'root',
    group => 'root',
    mode => '0664', # allow Puppet to re-write files as needed on Windows
    source => 'puppet:///modules/nginx/ngix.conf',
    }
 
 file {'default.conf':
  {
    ensure => file,
    path  =>  '/var/www/default.conf'
    owner => 'root',
    group => 'root',
    mode => '0664', # allow Puppet to re-write files as needed on Windows
    source => 'puppet:///modules/nginx/default.conf',
  service {'nginx ':
    ensure  =>  running,
    enable  =>  true,
    }
  
}
