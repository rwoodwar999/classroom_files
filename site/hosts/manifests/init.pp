class hosts::hosts {
  host { 'rwoodwar999.puppetlabs.vm':
    ensure => present,
    ip => '127.0.0.1',
  }
}
