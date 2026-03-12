<?php
$serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);
$certificateKeyFilePath = '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem';
$host = nckenowatch.o7lakg5.mongodb.net;
$port = 27017

$driver_options = [
    'authSource' => '$external',
    'authMechanism' => 'MONGODB-X509',
    'appName' => 'nckenoWatch',
    'tlsCertificateKeyFile' => $certificateKeyFilePath,
];


$client = new \MongoDB\Client('mongodb+srv://' . "$host:$port/?$driver_options" . ['serverApi' => $serverApi]);
print_r($client);
