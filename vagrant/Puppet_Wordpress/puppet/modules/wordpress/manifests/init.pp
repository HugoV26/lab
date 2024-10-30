class wordpress {

  notify {'install-wordpress':
    message => 'Starting wordpress installation'
  }

  package { "unzip":
    ensure => installed
  }
  
  exec { 'wget-wordpress':
    command => 'wget -P /var/www/html https://wordpress.org/latest.zip',
  }

  exec { 'Unzip-Wordpress':
    command     => 'unzip -o /var/www/html/latest.zip -d /var/www/html/',
    require => Exec["wget-wordpress"]
  }
  
  exec { 'Copy-Wordpress-Content':
    command => 'cp -r /var/www/html/wordpress/* /var/www/html',
    require => Exec['Unzip-Wordpress']
  }

  file { 'Copy-wp-config':
    path => "/var/www/html/wp-config.php",
    ensure => present,
    content => template("wordpress/wp-config-sample.php.erb"),
    require => Exec["Copy-Wordpress-Content"]
  }

  exec { 'wget-wpcli':
    command => 'wget -P /tmp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar',
    require => File["Copy-wp-config"]
  }

  file { '/tmp/wp-cli.phar':
    ensure => present,
    mode => '0644',
    require => Exec['wget-wpcli']
  }

  file { '/usr/local/bin/wp':
    ensure => present,
    source => '/tmp/wp-cli.phar',
    mode => '0755',
    require => File['/tmp/wp-cli.phar']
  }

  exec { 'install-wordpress':
    command => "/usr/local/bin/wp core install --url='http://192.168.100.30/' --title='UNIR-HEVZ' --admin_user=admwp --admin_password=temp123  --admin_email='hugo@mail.com' --path='/var/www/html'",
    require => File['/usr/local/bin/wp']
  }

  Exec { 'httpd-restart':
    command => 'sudo systemctl restart httpd',
    require => Exec['install-wordpress']
  }

}
