
<?php
$serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);
$certificateKeyFilePath = '/Users/rjallen/ecom/docker_compose/php-8.4.17/home_dir/certs/X509-cert-gcrUser.pem';
$client = new \MongoDB\Client(
  'mongodb+srv://nckenowatch.o7lakg5.mongodb.net/?authSource=%24external&authMechanism=MONGODB-X509&appName=nckenoWatch&tlsCertificateKeyFile=' . $certificateKeyFilePath,
  [], ['serverApi' => $serverApi],
);
$collection = $client->testDB->testCol;
$docCount = $collection->countDocuments();
echo $docCount, "\n";

