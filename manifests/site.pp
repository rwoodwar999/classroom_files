## site.pp ##

# Exercise 7.1
node 'josephoaks.puppetlabs.vm' {
  include system_users::admins
}

node default {
  include role::classroom
  
  # Exercise 6.2
  include system_users
}
