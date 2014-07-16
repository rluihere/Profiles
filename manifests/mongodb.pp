# == Class: profiles::mongodb
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
#  include profiles::mongodb
#
# === Authors
#
# Landuber Kassa <landuber.kassa@here.com>
#
# === Copyright
#
# Copyright 2014 HERE
#
class profiles::mongodb {
    class {'::mongodb::server':
      port    => 27018,
      verbose => true,
    }
}
