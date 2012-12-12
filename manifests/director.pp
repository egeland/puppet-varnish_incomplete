define varnish::director($backends,$policy='round-robin') {
  concat::fragment{"vcl director $name":
    target  => $varnish::params::vclfilename,
    content => template("varnish/vcl_director_fragment.erb"),
    order   => 5,
  }
}
