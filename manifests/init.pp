class varnish {
  include varnish::params, varnish::service
  include concat::setup
  package {$varnish::params::packagename:
    ensure => present,
  }
  exec {'varnish_activate':
    command => "sed -i s/'START=no'/'START=yes'/ /etc/default/varnish",
    unless  => "grep 'START=yes' /etc/default/varnish",
    onlyif  => 'test -f /etc/default/varnish',
  }
  exec {'varnish_change_default_port':
    command => "sed -i s/'a :6081'/'a :80'/ /etc/default/varnish",
    unless  => "grep 'a :80' /etc/default/varnish",
    onlyif  => 'test -f /etc/default/varnish',
  }
  concat{$varnish::params::vclfilename:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  concat::fragment{'vcl header':
    target  => $varnish::params::vclfilename,
    content => '# This file is managed by puppet
    # Local changes WILL be overwritten on the next puppet run
',
    order   => 01,
  }
  concat::fragment{'vcl vhost header':
    target  => $varnish::params::vclfilename,
    content => 'sub vcl_recv {
',
    order   => 6,
  }
  concat::fragment{'vcl vhost footer':
    target  => $varnish::params::vclfilename,
    content => 'remove req.http.X-Forwarded-For;
set req.http.X-Forwarded-For = client.ip;
}
',
    order   => 8,
  }
}

