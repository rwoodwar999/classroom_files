class hosts {
  host { 'pirate.puppetlabs.vm':
    ensure => present,
    ip     => '127.0.0.1',
  }
  
  host { 'punch.puppetlabs.vm':
    ensure => present,
    ip     => '127.0.0.1',
  }
}
