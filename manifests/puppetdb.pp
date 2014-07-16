# == Class: profiles::puppetdb
#
# PuppetDB profile
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
#  include profiles::puppetdb
#
# === Authors
#
# Landuber Kassa <landuber.kassa@here.com>
#
# === Copyright
#
# Copyright 2014 HERE
#
class profiles::puppetdb {
  include ::puppetdb
  include ::puppetdb::master::config
}
