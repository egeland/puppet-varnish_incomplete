class varnish::vhost($vhosts_data) {
  concat::fragment{"vcl vhost $name":
    target  => $varnish::params::vclfilename,
    content => template("varnish/vcl_vhost_fragment.erb"),
    order   => 7,
    notify => Class["varnish::service"],
  }
}
