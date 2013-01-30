class postgresql::params {

  $data_dir = $postgresql_data_dir ? {
    "" => $operatingsystem ? {
           /RedHat|Centos|CentOS/ => "/var/lib/pgsql",
           default => "/var/lib/postgresql",
    },

    default => $postgresql_data_dir,
  }
 
}
