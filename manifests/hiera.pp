# == Class: profiles::hiera
#
# Hiera profile
#
# === Parameters
#
# None
#
# === Variables
#
# None
#
# === Examples
#
#  include profiles::hiera
#
# === Authors
#
# Landuber Kassa <landuber.kassa@here.com>
#
# === Copyright
#
# Copyright 2014 HERE
#
class profiles::hiera {
  package { ['hiera', 'hiera-puppet']:
    ensure => present,
  }
}
