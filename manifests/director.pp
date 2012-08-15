define varnish::director($backends,$policy='round-robin') {
  concat::fragment{"vcl director $name":
    target  => $varnish::params::vclfilename,
    content => template('vcl_director_fragment.erb'),
    order   => 4,
  }
}
