class mysql {

  notify {'install-db':
    message => 'Starting database installation'
  }

  package { 'mariadb-server':
    ensure => installed
  }

  package { 'mariadb': 
    ensure => installed
  }

  service { 'mariadb':
    ensure => 'running',
    enable => 'true',
    require => Package['mariadb']
  }

  notify {'Database Installed':
    message => 'MySQL was installed succesfully',
    require => Service['mariadb']
  }

  file { 'Copy-SQL-file': 
    path => "/home/vagrant/createDB.sql",
    ensure => present,
    content => template('mysql/createDB.sql.erb'),
  }

  exec { 'Create-Wordpress-DB': 
    command =>  "mysql -h localhost -u root < /home/vagrant/createDB.sql",
    require => File['Copy-SQL-file']
  }

  notify { 'DB-Wordpress': 
    message => "Wordpress Database was created succesfully",
    require => Exec['Create-Wordpress-DB']
  }
  
}

