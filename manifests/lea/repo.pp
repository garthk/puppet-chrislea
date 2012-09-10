define chris::lea::repo() {
  include chris::lea::key
  $aptsource = "/etc/apt/sources.list.d/chris-lea-${name}-${lsbdistcodename}.list"
  file { $aptsource:
    ensure  => present,
    content => "deb http://ppa.launchpad.net/chris-lea/${name}/ubuntu ${lsbdistcodename} main\n",
  }

  exec { "apt-get update chrislea ${name}":
    command => "/usr/bin/apt-get update",
    require => [Exec['apt-key chrislea'], File[$aptsource]],
    creates => "/var/lib/apt/lists/ppa.launchpad.net_chris-lea_${name}_ubuntu_dists_${lsbdistcodename}_main_binary-${architecture}_Packages",
    timeout => 3600,
  }
}
