<?php
// we connect to localhost at port 3306
$link = mysql_connect('10.10.10.25:3306', 'bcuser', 'R0flSt0mp3d');
if (!$link) {
    die('Could not connect: ' . mysql_error());
}
echo 'Connected successfully';
mysql_close($link);
?>
E
