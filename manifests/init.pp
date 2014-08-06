# Class postfix

class postfix (
  $server_type            = 'satellite',
  $myhostname             = $::hostname,
  $mydomain               = $::domain,
  $myorigin               = $::fqdn,
  $mydestination          = $::fqdn,
  $mynetworks_style       = '',
  $mynetworks             = [],
  $access                 = [],
  $transport_maps         = [],
  $listen                 = 'localhost',
  $listenipv6             = true,
  $relayhost              = undef,
  $relay_domains          = [],
  $relay_recipients       = [],
  $message_size_limit     = '10240000',
  $ssl                    = false,
  $certhostname           = $::fqdn,
  $root_destination       = "root@${::domain}",
  $smtpd_timeout          = '300',
  $smtpd_error_sleep_time = '5',
) inherits postfix::params {
  #input validation
  validate_re(
    $server_type, '^(satellite|mxbackup|mx0)$', "${$server_type} is not supported for \$server_type.\nValid values are satellite or mxbackup."
  )
  validate_array(
    $mynetworks.
    $access,
    $transport_maps.
    $relay_domains,
    $relay_recipient,
  )
  validate_bool(
    $ssl,
    $listenipv6,
  )
  validate_string(
    $server_type,
    $myhostname,
    $mydomain,
    $myorigin,
    $mydestination,
    $mynetworks_style,
    $listen,
    $message_size_limit,
    $certhostname,
    $root_destination,
    $smtpd_timeout,
    $smtpd_error_sleep_time,
  )

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

