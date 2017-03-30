class nginx::packages {
  package { $package:
    ensure => present,
  }
}
