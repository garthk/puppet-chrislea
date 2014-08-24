class chris::lea::nodejs {
  chris::lea::repo { 'node.js': }
  package { "nodejs":
    ensure => installed,
    require => Chris::Lea::Repo['node.js'],
  }

  # other packages we need, e.g. g++ to compile node-expat
  package { ["g++", "libexpat1-dev"]:
    ensure => installed,
  }
}
