<?php

require_once '../../vendor/autoload.php';

$host = nckenowatch.o7lakg5.mongodb.net;
$port = '27017';
$serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);
$authSource = 'external';
$authMechanims = ['MONGODB-X509'];
$certificateKeyFilePath = '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem';

$uri = 'mongodb+srv://' . "$host" . ':' . "$port" . '/?tlsCertificateKeyFile=' . $certificateKeyFilePath . '&authSource=$external&authMechanism=MONGODB-X509&appName=nckenoWatch&tlsCertificateKeyFile=' . $certificateKeyFilePath;/testdb?authSource=$external&authMechanism=MONGODB-X509

$uriOptions
$driverOptions











?>