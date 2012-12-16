define varnish::backend($host,
                      $port,
                      $probe_url,
                      $probe_timeout   = '50',
                      $probe_interval  = '1',
                      $probe_window    = '7',
                      $probe_threshold = '3',
                      ) {
# We set up each backend with this define.
# They are then concatenated into the vcl file.
  concat::fragment{"vcl fragment ${name}":
    target  => $varnish::params::vclfilename,
    content => template('varnish/vcl_backend_fragment.erb'),
    order   => 4,
    notify  => Class['varnish::service']
  }
}
