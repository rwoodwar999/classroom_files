## site.pp ##

node 'josephoaks.puppetlabs.vm' {
  include system_users::admins
}

node default {
  include role::classroom
  include system_users
}
