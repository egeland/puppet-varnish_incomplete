class varnish {
  package {$varnish::params::packagename:
    ensure => present,
  }
  concat{$varnish::params::vclfilename:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  concat::fragment{'vcl header':
    target  => $varnish::params::vclfilename,
    content => '# This file is managed by puppet
    # Local changes WILL be overwritten on the next puppet run',
    order   => 01,
  }
}

