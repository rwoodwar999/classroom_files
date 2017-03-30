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
  
  include nginx::packages
  include nginx::configs
  include nginx::services
}
