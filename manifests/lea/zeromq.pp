class chris::lea::zeromq {
  chris::lea::repo { 'libpgm': }
  chris::lea::repo { 'zeromq': }
  package { 'libzmq-dev':
    ensure  => installed,
    require => [
      Chris::Lea::Repo['libpgm'],
      Chris::Lea::Repo['zeromq'],
    ],
  }
}
