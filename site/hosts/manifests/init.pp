class hosts {
  host { 'pirate.puppetlabs.vm':
    ensure => present,
    ip     => '127.0.0.1',
  }
}
