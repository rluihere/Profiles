# == Class: profiles::nodejs
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
#  include profiles::nodejs
#
# === Authors
#
# Landuber Kassa <landuber.kassa@here.com>
#
# === Copyright
#
# Copyright 2014 HERE
#
class profiles::nodejs {
    class {'::nodejs': }

    package { 'express':
        ensure   => present,
        provider => 'npm'
    }
}
