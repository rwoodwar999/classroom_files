## site.pp ##

# Exercise 7.1
node 'josephoaks.puppetlabs.vm' {
  include system_users::admins
  # Exercise 8.1
  include hosts
  # Exercise 8.2
  include nginx
  # Exercise 12.1
  nginx::vhost { 'punch.puppetlabs.vm': }
}

node default {
  include role::classroom
  
  # Exercise 6.2
  include system_users
}
