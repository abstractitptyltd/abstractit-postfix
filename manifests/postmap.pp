# Define postfix::postmap

define postfix::postmap (
  $ensure = file) {
  file { "/etc/postfix/${title}.db":
    ensure  => $ensure,
    mode    => '0644',
    require => [
      File["/etc/postfix/${title}"],
      Exec["generate ${title}.db"]]
  }

  exec { "generate ${title}.db":
    command     => "postmap /etc/postfix/${title}",
    path        => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    refreshonly => true
  }

}
