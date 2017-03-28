class system_users {
  user { 'fundamentals':
    ensure    => present,
#   password  => 'puppetlabs',    # Windows requires a plain text password
#   groups    => ['Users'],       # Display in Windows Control Panel
  }
}
