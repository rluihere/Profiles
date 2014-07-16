# == Class: profiles::yumrepo
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
#  include profiles::yumrepo
#
# === Authors
#
# Landuber Kassa <landuber.kassa@here.com>
#
# === Copyright
#
# Copyright 2014 HERE
#
class profiles::yumrepo {
  class {'::apache': }

  apache::vhost {'puppetrepo':
    docroot    => '/var/www/html/puppetrepo',
  }
}
