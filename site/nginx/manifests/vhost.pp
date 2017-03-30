define nginx::vhost (
  $port       = '80',
  $docroot    = "${nginx::docroot}/vhosts/${title}",
  $servername = $title,
) {

  File {
    ensure => file,
    owner  => $nginx::owner,
    group  => $nginx::group,
    mode   => '0664',
  }
  
  file { "nginx-vhost-${title}":
    path    => "${nginx::blockdir}/${title}.conf",
    content => epp('nginx/vhost.conf.epp', {
      port       => $port,
      docroot    => $docroot,
      title      => $title,
      servername => $servername,
    }),
    notify  => Service['nginx'],
  }
  
  file { "${docroot}/index.html":
    content => epp('nginx/index.html.epp', {
      servername => $servername,
    }),
  }
  
  file { [ "${nginx::docroot}/vhosts/", $docroot ]:
    ensure => directory,
    before => File["${docroot}/index.html"],
  }
}
