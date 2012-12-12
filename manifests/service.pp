class varnish::service {
  service { varnish:
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
  }
}
