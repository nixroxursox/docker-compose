<?php

require '/code/vendor/autoload.php';
$manager = new MongoDB\Driver\Manager("mongodb://root:example@localhost:27017/BCMART");
var_dump($manager);

function openMongoDB() {
	require '/code/vendor/autoload.php';
	//$m = new MongoDB\Client('mongodb://root:example@localhost:27017'); // connect
	$m = new MongoDB\Client(
'mongodb://172.16.168.20:27017/BCMART',
	[
		'username' => 'root',
		'password' => 'example',
		'authSource' => 'admin'
	],
);
	return $dbm = $m;


		/* Setting the correct charset for db connection as mentioned here: http://www.phptherightway.com/#php_and_utf8 */
		//return new \PDO('mysql:host=' . DB_HOSt;dbname=' . DB_NAME . ';charset=utf8mb4', DB_USER, DB_PASS, $options);
		/* Setting the correct charset for db connection as mentioned here: http://www.phptherightway.com/#php_and_utf8 */
		//return new \PDO('mysql:dbname=BCMART;unix_socket=/var/run/mysqld/mysqld.sock;charset=utf8mb4', 'bcuser', 'R0flSt0mp3d', $options);
}

$client = openMongoDB();
foreach ($client->listDatabases() as $databaseInfo) {
    var_dump($databaseInfo);
}


