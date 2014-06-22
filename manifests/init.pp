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
  $relayhost              = undef,
  $relay_domains          = [$::domain],
  $relay_recipients       = [],
  $message_size_limit     = '15M',
  $ssl                    = false,
  $certhostname           = $::fqdn,
  $root_destination       = "root@${::domain}",
  $smtpd_timeout          = '300',
  $smtpd_error_sleep_time = '5') inherits postfix::params {
  validate_re($server_type, '^(satellite|mxbackup|mx0)$', "${$server_type} is not supported for \$server_type.\nValid values are satellite or mxbackup."
  )
  validate_array($mynetworks)
  validate_array($access)
  validate_array($transport_maps)
  validate_array($relay_domains)
  validate_array($relay_recipients)
  validate_bool($ssl)

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

