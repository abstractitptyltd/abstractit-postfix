class postfix::service (
) inherits postfix::params {
  service { 'postfix':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Class[postfix::install],
  }

}
