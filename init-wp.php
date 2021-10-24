<?php
chdir('/var/www/html');

function wp($command, $args = [])
{
    $command = "wp $command";
    foreach ($args as $k => $v) {
        $command .= " --$k";
        if ($v !== '') {
            $command .= "=$v";
        }
    }
    $command .= ' --allow-root';
    $output = shell_exec($command);
    if ($output) {
        echo $output;
    } else {
        echo "Failed: $command";
        exit;
    }
}

wp('core download');

define('MYSQL_HOSTNAME', 'db');
define('MYSQL_DATABASE', getenv('MYSQL_DATABASE'));
define('MYSQL_USER', getenv('MYSQL_USER'));
define('MYSQL_PASSWORD', getenv('MYSQL_PASSWORD'));

$trial = 10;
while ($trial--) {
    $conn = new mysqli(MYSQL_HOSTNAME, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE);
    if ($conn->connect_error) {
        echo 'MySQL connection failed: ' . $conn->connect_error;
        sleep(5);
    } else {
        break;
    }
}
if ($conn->connect_error) {
    echo 'All retries fail.';
    exit(1);
}
$conn->close();

wp('config create', [
    'dbname' => MYSQL_DATABASE,
    'dbuser' => MYSQL_USER,
    'dbpass' => MYSQL_PASSWORD,
    'dbhost' => MYSQL_HOSTNAME,
]);
wp('core install', [
    'url' => '"https://www.local-wp.test"',
    'title' => '"Local WordPress Development"',
    'admin_user' => 'admin',
    'admin_password' => 'admin',
    'admin_email' => 'admin@local-wp.test',
    'skip-email' => '',
]);
wp('plugin delete akismet hello');
wp('theme delete twentynineteen twentytwenty');

// enable WordPress debug mode
$configContent = file_get_contents('wp-config.php');
$pos = strpos($configContent, '/* That\'s all, stop editing! Happy publishing. */');
$debug = <<<PHP
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
@ini_set('display_errors', 0);
define('SCRIPT_DEBUG', true);
PHP;
$configContent = substr($configContent, 0, $pos) . $debug . "\n" . substr($configContent, $pos);
file_put_contents('wp-config.php', $configContent);

shell_exec('chown ' . getenv('APACHE_RUN_USER') . ' /var/www/html -R');
shell_exec('chgrp ' . getenv('APACHE_RUN_GROUP') . ' /var/www/html -R');
