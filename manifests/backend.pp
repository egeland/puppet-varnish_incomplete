define varnish::backed($ip,$port) {
# We set up each backend with this define.
# They are then concatenated into the vcl file.
  concat::fragment{"vcl fragment $name":
    target  => $varnish::params::vclfilename,
    content => template('vcl_backend_fragment.erb'),
    order   => 5,
  }
}
