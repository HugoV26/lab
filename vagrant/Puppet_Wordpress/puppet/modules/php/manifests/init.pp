class php {
  notify {'install-php':
    message => 'Starting php installation'
  }
  
  exec { 'install-epel-release': 
    command => 'sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
  }

  exec { 'install-remi-repo': 
    command => "sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y",
    #require => Exec["install-epel-release"]
  }

  exec { "configure-repo": 
    command => "sudo yum-config-manager --enable remi-php74",
    require => Exec["install-remi-repo"]
  }

  package { ['php', 'php-mysql', 'php-curl', 'php-gd', 'php-mbstring', 'php-xml', 'php-xmlrpc', 'php-soap', 'php-common', 'php-mcrypt', 'php-cli']:
    ensure => 'installed',
    require => Exec["configure-repo"],
    notify  => Notify['PHP-Installed'],
  }
  
  notify { 'PHP-Installed':
    message => "PHP7.4 has been succesfully installed",
  }

}
