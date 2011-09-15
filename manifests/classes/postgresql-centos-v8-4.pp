/*

==Class: postgresql::centos::v8-4

Parameters:
 $postgresql_data_dir:
    set the data directory path, which is used to store all the databases

Requires:
 - Class["apt::preferences"]

*/
class postgresql::centos::v8-4 {

  $version = "84"

  case $lsbmajdistreelease {
    "5" : {

      include postgresql::centos::base

      service {"postgresql":
        ensure    => running,
        enable    => true,
        hasstatus => true,
        start     => "/etc/init.d/postgresql start ${version}",
        status    => "/etc/init.d/postgresql status ${version}",
        stop      => "/etc/init.d/postgresql stop ${version}",
        restart   => "/etc/init.d/postgresql restart ${version}",
        require   => Package["postgresql-server"],
      }

      package { "postgresql-server":
        name => "postgresql${version}-server",
		ensure => present,
	  }
    }

    default: {
      fail "postgresql ${version} not available for ${operatingsystem}/${lsbdistcodename}"
    }
  }
}
