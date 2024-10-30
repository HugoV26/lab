class httpd {
  notify {'install-apache':
    message => 'Starting apache installation'
  }
  
  package { 'httpd':
    ensure => installed
  }
  
  service { 'httpd':
    ensure => running,
    enable => true,
  }
  
  notify {'Apache Installed':
    message => "Apache was installed and started",
    require => Service['httpd']
  }
  
  service { 'firewalld':
    name => firewalld,
    ensure => stopped,
    enable => false
  }

  notify {'Firewalld Disabled':
    message => "Firewall was disabled and stopped",
    require => Service['firewalld']
  }   
}
