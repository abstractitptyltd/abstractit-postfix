# Define postfix::config::master_process

define postfix::config::master_process (
  $content,
  $order = 20) {
  $postfix_master_cf = $postfix::params::postfix_master_cf

  concat::fragment { "postfix_master_cf_${name}":
    target  => $postfix_master_cf,
    content => $content,
    order   => $order,
  }

}
