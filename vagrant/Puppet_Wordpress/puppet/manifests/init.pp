Exec { path => ["/bin/", "/sbin", "/usr/bin/", "/usr/sbin"] }

require httpd
require mysql
require php
require wordpress

notify { 'Welcome':
  message => "\n\nNow you can access to http://192.168.100.30"
}
