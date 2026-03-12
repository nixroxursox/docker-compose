
<?php

require_once('../../vendor/autoload.php');

$serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);
$serverApi->strict = true;

$host = 'nckenowatch.o7lakg5.mongodb.net';
$shard0 = 'ac-w3hpido-shard-00-00.o7lakg5.mongodb.net:27017'; 
$shard1 = 'ac-w3hpido-shard-00-01.o7lakg5.mongodb.net:27017';
$shard2 = 'ac-w3hpido-shard-00-02.o7lakg5.mongodb.net:27017';
$port = 27017;

$certificateKeyFilePath = '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem';

$uriOptions = [
    'appName' => "nckenoWatch",
    'certificateKeyFilePath' => "$certificateKeyFilePath",
    'document_class' => "dict",
    'uuidRepresentation' => "standard",
    'authSource' => "$external",
    'authMechanism' => "MONGODB-X509",
    'retryWrites' => true,
    'maxIdleTimeMS' => 6000,
    'maxConnecting' => 12,
    'maxPoolSize' => 150,
    'w' => "w",
    'tls' => true,
    'tz_aware' =>  true,
    'tzinfo' =>  "pytz.timezone(\"US/Eastern\")",
    'tlsCertificateKeyFile' => '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem',
    'compressors' => "zlib",
    'zlibCompressionLevel' => -1,
    'connect' => true  
];


try  {
        $client = new \MongoDB\Client('mongodb+srv://' . "$host" . ':' . $port . '/?' ,[$uriOptions], ['serverApi' => $serverApi],);
	print_r($client);
        $collection = $client->testDB->testCol;
        $docCount = $collection->countDocuments();
        echo "Connected successfully to server";
    } catch (\MongoDB\Driver\Exception\Exception $e) {
        echo "Connection failed: " . $e->getMessage();
}


var_dump($docCount);
var_dump($client);

