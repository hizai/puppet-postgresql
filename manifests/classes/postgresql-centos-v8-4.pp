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

  case $lsbmajdistrelease {
    "5" : {

      include postgresql::centos::base

      Service["postgresql"] {
        start   => "/sbin/service postgresql start",
        status  => "/sbin/service postgresql status",
        stop    => "/sbin/service postgresql stop",
        restart => "/sbin/service postgresql restart",
      }

      service {"postgresql":
        ensure    => running,
        require   => [Package["postgresql-server"], Exec["init-db"]]
      }

      package { "postgresql-server":
        name => "postgresql${version}-server",
		ensure => present,
	  }
    }

    "6" : {

      include postgresql::centos::base

      Service["postgresql"] {
        start   => "/sbin/service postgresql start",
        status  => "/sbin/service postgresql status",
        stop    => "/sbin/service postgresql stop",
        restart => "/sbin/service postgresql restart",
      }

      service {"postgresql":
        ensure    => running,
        require   => [Package["postgresql-server"], Exec["init-db"]]
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
