<?php
  function getClientIP() {
    if (isset($_SERVER)) {
      if (isset($_SERVER["HTTP_X_FORWARDED_FOR"]))
        return $_SERVER["HTTP_X_FORWARDED_FOR"];
      if (isset($_SERVER["HTTP_CLIENT_IP"]))
        return $_SERVER["HTTP_CLIENT_IP"];
      return $_SERVER["REMOTE_ADDR"];
    }
    if (getenv('HTTP_X_FORWARDED_FOR'))
      return getenv('HTTP_X_FORWARDED_FOR');
    if (getenv('HTTP_CLIENT_IP'))
      return getenv('HTTP_CLIENT_IP');
    return getenv('REMOTE_ADDR');
  }
  function getUptime() {
    $data = explode(',', explode(' up', shell_exec('uptime'))[1]);
    return $data[0];
  }
  
  $ip_client = getClientIP();
  $uptime = getUptime();
  
  echo "Hello World! You have successfully deployed your PHP application to your Apache server.<br><br>";
  echo "Server Uptime: $uptime <br>";
  echo "Your IP: $ip_client <br><br>";
  phpinfo();
?>
