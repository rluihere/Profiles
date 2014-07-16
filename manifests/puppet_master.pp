# == Class: profiles::puppet_master
#
# Puppet Master profile
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
#  include profiles::puppet_master
#
# === Authors
#
# Landuber Kassa <landuber.kassa@here.com>
#
# === Copyright
#
# Copyright 2014 HERE
#
class profiles::puppet_master {
  include epel
  class { '::puppet::master':
    storeconfigs => true,
    environments => 'directory',
  }

  firewall { '100 allow agent checkins':
    dport  => 8140,
    proto  => tcp,
    action => accept,
  }

  firewall { '110 sinatra web hook':
    dport  => 80,
    proto  => tcp,
    action => accept,
  }
}
