class nginx {
  package { 'nginx':
  ensure => present,
  before  => [File['nginx.conf'],File['default.conf'] ],
  }

file { 'docroot':
    ensure => directory,
    path =>  '/var/www',
    owner => 'root',
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
  file { 'nginx.conf':
    ensure  => file,
    path    =>  '/var/www/nginx.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0664', # allow Puppet to re-write files as needed on Windows
    source  => 'puppet:///modules/nginx/nginx.conf',
   
     }
 
 file {'default.conf':
    ensure => file,
    path  =>  '/var/www/default.conf',
    owner => 'root',
    group => 'root',
    mode => '0664', # allow Puppet to re-write files as needed on Windows
    source => 'puppet:///modules/nginx/default.conf',
    }
  service {'nginx':
    ensure  =>  running,
    enable  =>  true,
    subscribe  => ['File['nginx.conf']',['File['default.conf']',
    }
  
}
