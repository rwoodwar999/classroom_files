## site.pp ##

# Exercise 7.1
node 'josephoaks.puppetlabs.vm' {
  include system_users::admins
  # Exercise 8.1
  include hosts
}

node default {
  include role::classroom
  
  # Exercise 6.2
  include system_users
}
