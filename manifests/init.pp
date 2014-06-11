# Class postfix

class postfix (
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
  class { '::postfix::install': } ->
  class { '::postfix::config':
    server_type            => $server_type,
    myhostname             => $myhostname,
    mydomain               => $mydomain,
    myorigin               => $myorigin,
    mydestination          => $mydestination,
    mynetworks_style       => $mynetworks_style,
    mynetworks             => $mynetworks,
    access                 => $access,
    transport_maps         => $transport_maps,
    listen                 => $listen,
    relayhost              => $relayhost,
    relay_domains          => $relay_domains,
    relay_recipients       => $relay_recipients,
    message_size_limit     => $message_size_limit,
    ssl                    => $ssl,
    certhostname           => $certhostname,
    root_destination       => $root_destination,
    smtpd_timeout          => $smtpd_timeout,
    smtpd_error_sleep_time => $smtpd_error_sleep_time
  } ~>
  class { '::postfix::service': }
}
