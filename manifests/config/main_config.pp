# Define postfix::config::main_config

define postfix::config::main_config (
  $content,
  $order = 20) {
  $postfix_main_cf = $postfix::params::postfix_main_cf

  concat::fragment { "postfix_main_cf_${name}":
    target  => $postfix_main_cf,
    content => $content,
    order   => $order
  }

}
