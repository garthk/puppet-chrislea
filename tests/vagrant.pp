stage { pre: before => Stage[main] }

class apt_get_update {
  $sentinel = "/var/lib/apt/first-puppet-run"

  exec { "initial apt-get update":
    command => "/usr/bin/apt-get update && touch ${sentinel}",
    onlyif  => "/usr/bin/env test \\! -f ${sentinel} || /usr/bin/env test \\! -z \"$(find /etc/apt -type f -cnewer ${sentinel})\"",
    timeout => 3600,
  }
}

class test_server {
  group { 'puppet':
    ensure => "present",
  }

  class { 'apt_get_update':
    stage => pre
  }

  class { 'chris::lea::nodejs':
    stage => main
  }
}

include test_server
