#  Class postfix::config

class postfix::config (
  $server_type            = $postfix::params::server_type,
  $myhostname             = $postfix::params::myhostname,
  $mydomain               = $postfix::params::mydomain,
  $myorigin               = $postfix::params::myorigin,
  $mydestination          = $postfix::params::mydestination,
  $mynetworks_style       = $postfix::params::mynetworks_style,
  $mynetworks             = $postfix::params::mynetworks,
  $access                 = $postfix::params::access,
  $transport_maps         = $postfix::params::transport_maps,
  $listen                 = $postfix::params::listen,
  $relayhost              = $postfix::params::relayhost,
  $relay_domains          = $postfix::params::relay_domains,
  $relay_recipients       = $postfix::params::relay_recipients,
  $message_size_limit     = $postfix::params::message_size_limit,
  $ssl                    = $postfix::params::ssl,
  $certhostname           = $postfix::params::certhostname,
  $root_destination       = $postfix::params::root_destination,
  $smtpd_timeout          = $postfix::params::smtpd_timeout,
  $smtpd_error_sleep_time = $postfix::params::smtpd_error_sleep_time) inherits postfix::params {
  $postfix_master_cf = $postfix::params::postfix_master_cf
  $postfix_main_cf   = $postfix::params::postfix_main_cf

  concat { $postfix_master_cf:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class[postfix::service]
  }

  postfix::config::master_process { 'header':
    content => "\n##Managed with Puppet modifications will be overwritten:\n\n",
    order   => 01,
  }

  postfix::config::master_process { 'postfix master default':
    content => template('postfix/master_cf_default.erb'),
    order   => 10,
  }

  concat { '/etc/postfix/main.cf':
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Class[postfix::service]
  }

  postfix::config::main_config { 'header':
    content => "\nManaged with Puppet modifications will be overwritten:\n\n",
    order   => 01,
  }

  postfix::config::main_config { 'default':
    content => template('postfix/main_cf_default.erb'),
    order   => 10,
  }

  postfix::config::main_config { 'smtpd_sender_restrictions':
    content => template('postfix/smtpd_sender_restrictions.erb'),
    order   => 20,
  }

  postfix::config::main_config { 'smtpd_recipient_restrictions':
    content => template('postfix/smtpd_recipient_restrictions.erb'),
    order   => 20,
  }

  file { '/etc/postfix/access':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('postfix/access.erb'),
    notify  => Postfix::Postmap['access'],
  }

  postfix::postmap { 'access': }

  file { '/etc/postfix/transport':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('postfix/transport.erb'),
    notify  => Postfix::Postmap['transport'],
  }

  postfix::postmap { 'transport': }

  file { '/etc/aliases':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('postfix/aliases.erb'),
    notify  => Exec['postalias'],
  }

  exec { 'postalias':
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    command     => 'postalias hash:/etc/aliases',
    refreshonly => true,
  }

  file { '/etc/postfix/relay_domains':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('postfix/relay_domains.erb'),
    notify  => Class[postfix::service],
  }

  file { '/etc/postfix/relay_recipients':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('postfix/relay_recipients.erb'),
    notify  => Postfix::Postmap['relay_recipients'],
  }

  postfix::postmap { 'relay_recipients': }

}
