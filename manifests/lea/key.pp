class chris::lea::key {
  $key = "C7917B12"
  exec { 'apt-key chrislea':
    path    => "/bin:/usr/bin",
    unless  => "apt-key list | grep '${key}' | grep -v expired",
    command => "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${key}",      
  }
}
