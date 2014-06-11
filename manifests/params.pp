class postfix::params (
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
  $smtpd_error_sleep_time = '5',) {
  $postfix_master_cf = '/etc/postfix/master.cf'
  $postfix_main_cf   = '/etc/postfix/main.cf'
}
