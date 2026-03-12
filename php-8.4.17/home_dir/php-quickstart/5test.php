<?php

require_once('4test.php');

$db = new Database();

$client = $db->get_client();

$dbs = $client->listDatabases();

foreach ($dbs as $db) {
    echo $db['name'] . "\n";
}


?>
