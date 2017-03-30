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
  
  $user = $facts['os']['family'] ? {
    'redhat' => 'nginx',
    'debian' => 'nobody',
    default  => 'www',
  }
}
