# == Class: profiles::nginx
#
# Create a yum-compatible repo
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
#  include profiles::nginx
#
# === Authors
#
# Landuber Kassa <landuber.kassa@here.com>
#
# === Copyright
#
# Copyright 2014 HERE
#
class profiles::nginx {
    class {'::nginx': }
}
