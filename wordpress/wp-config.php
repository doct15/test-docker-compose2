<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'root');
define('DB_PASSWORD', '');
define('DB_HOST', "db:3306");
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         'ABRACADABRA');
define('SECURE_AUTH_KEY',  'ABRACADABRA');
define('LOGGED_IN_KEY',    'ABRACADABRA');
define('NONCE_KEY',        'ABRACADABRA');
define('AUTH_SALT',        'ABRACADABRA');
define('SECURE_AUTH_SALT', 'ABRACADABRA');
define('LOGGED_IN_SALT',   'ABRACADABRA');
define('NONCE_SALT',       'ABRACADABRA');

$table_prefix  = 'wp_';
define('WPLANG', '');
define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
  define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
?>
