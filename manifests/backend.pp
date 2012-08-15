define varnish::backed($host,
                       $port,
                       $probe_url,
                       $probe_timeout   = '50',
                       $probe_interval  = '1',
                       $probe_window    = '3',
                       $probe_threshold = '7',
                       ) {
# We set up each backend with this define.
# They are then concatenated into the vcl file.
  concat::fragment{"vcl fragment $name":
    target  => $varnish::params::vclfilename,
    content => template('vcl_backend_fragment.erb'),
    order   => 5,
  }
}
