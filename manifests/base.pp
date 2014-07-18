# == Class: profiles::base
#
# Base profile
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
#  include profiles::base
#
# === Authors
#
# Landuber Kassa <landuber.kassa@here.com"
#
# === Copyright
#
# Copyright 2014 HERE
#
class profiles::base {
  include base::set_repos
  include base::users
  include base::crond
  include base::facts
  include base::issue
  include base::ssh_config
  #include base::sudoers_conf
}
