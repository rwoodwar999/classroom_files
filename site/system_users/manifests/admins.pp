class system_users::admins {
  user { 'admins':
    ensure  =>  present,
    gid     =>  'staff',
    shell   =>  '/bin/csh',
  }
  
  group { 'staff':
    ensure  =>  present,
  }
}
