<?php

require_once '../../vendor/autoload.php';

$driver_name = MongoDB\Driver\Manager::setDriverName('mongodb');
$host = nckenowatch.o7lakg5.mongodb.net;
$port = 27017;
$serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);
$certificateKeyFilePath = '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem';

$driver_options = [
    'authSource' => '$external',
    'authMechanism' => 'MONGODB-X509',
    'appName' => 'nckenoWatch',
    'tlsCertificateKeyFile' => $certificateKeyFilePath,
];

try {
	$client = new \MongoDB\Client('mongodb+srv://' . "$host:port" . '/?' . "$driver_options",[], ['serverApi' => $serverApi],);

}  catch (MongoDB\Driver\Exception\MongoConnectionException $e) {
	die('Failed to connect to MongoDB: ' . $e->getMessage());
}


print_r($client)



?>
