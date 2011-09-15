/*

==Class: postgresql::debian::base

This class is dedicated to the common parts 
shared by the different flavors of Debian

*/
class postgresql::centos::base inherits postgresql::base {

  include postgresql::params

  Package["postgresql"] {
    name   => "postgresql${version}",
	notify => Exec ["init-db"],
  }

  File["pg_hba.aug"] {
    name => "/usr/share/augeas/lenses/dist/pg_hba.aug",
  }

  package {[
    "postgresql${version}-libs",
    "postgresql${version}-contrib",
	"libxslt"
    ]:
    ensure  => present,
    require => Package["postgresql"],
  }

  exec { "init-db":
    command => "/sbin/service postgresql initdb",
    require => [Package["postgresql"], Package["postgresql-server"]],
    unless => "/bin/su postgres -c '/usr/bin/pg_ctl status -D /var/lib/pgsql/data'",
  } 
}
