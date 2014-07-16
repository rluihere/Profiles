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

  #  Set up yum repos
  class set_repos {

    yumrepo { "RCS-Custom":
      baseurl   => "http://54.193.1.156/RCS-Custom/",
      descr   => "RCS Custom Repository",
      enabled   => 1,
      gpgcheck  => 0,
    }

    yumrepo { "MongoDB":
      baseurl   => "http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/",
      descr   => "MongoDB Repository",
      enabled   => 1,
      gpgcheck  => 0,
    }

  }

  #users

  class users {

    group { 'rcsbot':
            ensure          => present,
            gid   => 501,
    }

    group { 'lakassa':
            ensure          => present,
            gid   => 1914,
    }

    group { 'astarov':
            ensure          => present,
            gid           => 1916,
    }

    group { 'tslankard':
            ensure          => present,
            gid           => 1917,
    }


    user { 'rcsbot':
            ensure    => present,
            uid   => 501,
            gid   => 'rcsbot',
            password  => '$6$Z2O1Ldh6$mMRRO09/Uy6Wrl2w25zGdh.hCXJ.Ea0c5QkWgThWNaCiDZ0Magn9Uk.VF1ThCD7HbhbotJvBlkhp2dxBEddSq/',
            comment   => '$hostname rcsbot',
            groups    => ["rcsbot","wheel"],
            require   => Package['ruby-shadow'],
            managehome  => true,
    }


    user { 'lakassa':
            ensure    => present,
            uid   => 1914,
            gid   => 'lakassa',
            password  => '$6$VgWrNj3Z$Oh03zODE3dA3UD6ywU2QK7CCPfy8l76V5NqTBzfgGG87Dwqs8dpIs7zkIehySv.xUmGreokqPYFMJInEZPjg2/',
            comment   => '$hostname lakassa',
            #groups   => ["lakassa","wheel"],
            require   => Package['ruby-shadow'],
            managehome  => true,
    }


    user { 'astarov':
            ensure    => present,
            uid   => 1916,
            gid   => 'astarov',
            password  => '$6$FYXtn1qX$2PFvRQ5l6SfNUXHz7C0xS8yCBaAnf1HaEBqMW4pV9DV6YT1acyoRhdOM8ZeMospbkLDgPTTT.058g.gGnZ32i0',
            comment   => '$hostname astarov',
            #groups   => ["astarov","wheel"],
            require   => Package['ruby-shadow'],
            managehome  => true,
    }

    user { 'tslankard':
            ensure    => present,
            uid   => 1917,
            gid   => 'tslankard',
            password  => '$6$xjLouVT6$cA1AEqOHB.hKjd3POMAlpQKVHn8g1x4balrHOupyq0i7ClgaDwItiDnlkjw9.zarPlIe708PxN8n7w/HGd.nQ.',
            comment   => '$hostname tslankard',
            #groups   => ["tslankard","wheel"],
            require   => Package['ruby-shadow'],
            managehome  => true,
    }


    user { 'root':
      comment   => $hostname,
                  password  => '$6$u.6FvccE$qkwBWHR.3sEZyGnsCUKp9I67MJx575bi1I9bBCqSbK01MjdemauffttyGeGF91TncEEWOob0OLOQAStGhc5/e/',
    }


    package { 'ruby-shadow':
      ensure    => present,
      provider  => yum,
    }

    package { 'oddjob':
      ensure    => present,
      provider  => yum,
    }

    service { 'oddjobd':
                  ensure          => "running",
                  enable          => "true",
      require   => Package['oddjob'],
      hasstatus => true,
    }


    file { '/home/users':
      ensure    => directory,
      owner   => root,
      group   => root,
      mode    => 777,
    }

    file { [ '/home/rcsbot/.ssh' ]:
            mode            => 700,
            owner           => rcsbot,
            group           => rcsbot,
            ensure          => directory,
            require         => User['rcsbot'],
    }

    file { '/home/rcsbot/.ssh/authorized_keys':
           # path            => "/home/rcsbot/.ssh/authorized_keys",
            ensure    => present,
            owner           => rcsbot,
            group           => rcsbot,
            mode            => 600,
            source          => 'puppet:///modules/users/authorized_keys.rcsbot',
            require         => User['rcsbot'],
    }

    file { '/home/rcsbot/.ssh/id_rsa':
            path            => "/home/rcsbot/.ssh/id_rsa",
            owner           => rcsbot,
            group           => rcsbot,
            mode            => 600,
            source          => 'puppet:///modules/users/id_rsa.rcsbot',
            require         => User['rcsbot'],
    }

    file { '/home/rcsbot/.bash_profile':
      ensure    => present,
      owner   => rcsbot,
      group   => rcsbot,
      mode    => 644,
      source    => 'puppet:///modules/users/rcsbot/.bash_profile.rcsbot',
      require   => User['rcsbot'],
    }

    file { '/etc/profile':
      ensure    => present,
                  owner   => root,
                  group   => root,
                  mode    => 644,
                  source    => 'puppet:///modules/users/profile',
    }
  }


  # crond
  class crond {
    file { "/etc/cron.allow":
      owner   => root,
      group   => root,
      mode    => 400,
      source    => "puppet:///modules/crond/cron.allow"
    }

    file { "/etc/at.allow":
            owner   => root,
            group   => root,
            mode    => 400,
            source    => "puppet:///modules/crond/at.allow"
    }

    file { "/etc/cron.deny":
      ensure    => absent,
    }

    file { "/etc/at.deny":
      ensure    => absent,
    }
  }


  # facts
  class facts {
    file { '/etc/facts':
      ensure    => directory,
      path    => '/etc/facts',
      owner   => root,
      group   => root,
      mode    => 644,
  }

  # issue
  class issue {
        file { '/etc/issue':
                path    => "/etc/issue",
                owner   => root,
                group   => root,
                mode    => 644,
                source    => 'puppet:///modules/issue/issue',
        }
  }

  #sshd
  class ssh_config {
    file { '/etc/ssh/sshd_config':
      path    => "/etc/ssh/sshd_config",
                  owner   => root,
                  group   => root,
                  mode    => 600,
      source    => 'puppet:///modules/sshd/sshd_config',
    }

    service { 'sshd':
      ensure    => running,
      subscribe => File["/etc/ssh/sshd_config"],
      require   => File['/etc/ssh/sshd_config'],
    }

  }

 #sudoer configuration
 class sudoers_conf {
  file { '/etc/sudoers':
          path    => '/etc/sudoers',
          owner   => root,
          group   => root,
          mode    => 440,
          source    => "puppet:///modules/sudoers_conf/sudoers",
  }

  file { "/etc/security/access.conf":
                path    => '/etc/security/access.conf',
    owner   => root,
    group   => root,
    mode    => 644,
    source    => "puppet:///modules/sudoers_conf/access.conf",
  }
 }




  # exisitng
  include ::motd
  include profiles::base::set_repos
  include profiles::base::users
  include profiles::base::crond
  include profiles::base::facts
  include profiles::base::issue
  include profiles::base::ssh_config
  include profiles::base::sudoers_conf
}
