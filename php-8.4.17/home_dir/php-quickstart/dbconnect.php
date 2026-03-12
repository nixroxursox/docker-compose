<?php

require_once __DIR__ . '/vendor/autoload.php';
use MongoDB\Client;

$mhost1 = 'ac-w3hpido-shard-00-01.o7lakg5.mongodb.net';
$mhost0 = 'ac-w3hpido-shard-00-00.o7lakg5.mongodb.net';
$mhost2 = 'ac-w3hpido-shard-00-02.o7lakg5.mongodb.net';
$mport = 27017;
$serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1)
$certificateKeyFilePath = '/home/phpUser/certs';
$certficateKey = 'X509-cert-gcrUser.pem';
$authMechanism = 'MONGODB-X509';
$uriOptions = array(
                  'appName' => 'nckenoWatch',
                  'tlsCertificateKeyFile' => $certificateKeyFilePath.'/'.$certficateKey,
                  'authSource' => '$external',
                  'authMechanism' => 'MONGODB-X509',
                  'ssl' => true,
                  'compressors' => 'snappy,zstd,zlib',
                  'zlibCompressionLevel' => 1,
                  'serverSelectionTimeoutMS' => 10000
            );
$uri = 'mongodb+srv://$mhost0:$mport, $mhost1:$mport, $mhost2:$mport';
$client = new Client($uri, $uriOptions,  ['serverApi' => $serverApi]);

print "$client \n"

try {
    $client->test->command(['ping' => 1]);
    echo 'Successfully pinged the MongoDB server.', PHP_EOL;
} catch (MongoDB\Driver\Exception\RuntimeException $e) {
    printf("Failed to ping the MongoDB server: %s\n", $e->getMessage());
}


