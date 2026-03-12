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



// $uri = "mongodb+srv://$mhost0:$mport, $mhost1:$mport, $mhost2:$mport/testdb?authSource=\$external&authMechanism=MONGODB-X509&appName=nckenoWatch&tlsCertificateKeyFile=$certificateKeyFilePath/$certficateKey";$uriOptions,  ['serverApi' => $serverApi]);o

// try {
// 	$client = new \MongoDB\Client('mongodb+srv://nckenowatch.o7ism=&appName=nckenoWatch&['serverApi' => $serverApi],);
//         $collection = $client->testDB->testCol;
//         $docCount = $collection->countDocuments();
// }  catch (MongoDB\Driver\Exception\Exception $e) {
// 	echo "Exception:", $e->getMessage(), "\n";
// }

// $collection = $client->GiftCardReclaim->customer;
// $options = [
//     '_id' => 0,
//     'username' => 1,
//     'password' => 1,
// ];

try {
        $cursor = $collection->find(['login_data.username' => 'rjallen'], $options);
        foreach ($cursor as $doc) {
        echo json_encode($doc), PHP_EOL;
        }

}  catch (MongoDB\Driver\Exception\Exception $e) {
        echo "Exception:", $e->getMessage(), "\n";
}




//         $document_class = 'dict';
//         $w = "majority";
//         $host = 'nckenowatch.o7lakg5.mongodb.net';
//         $port = 27017
//         $uri = "mo7ngodb+srv:$host:$port
//         $client = AsyncMongoClient(
//             $uri,
//             document_class=$document_class,
//             uuidRepresentation="standard",
//             authSou0
//             authMechanism="MONGODB-X509",
//             retryWrites=True,
//             maxIdleTimeMS1=6000,
//             maxConnecting=12,
//             maxPoolSize=150,
//             w=w,
//             tls=True,
//             tz_aware=True,
//             tzinfo=pytz.timezone("US/Eastern"),
//             tlsCertificateKeyFile="certs/X509-cert-gcrUser-0526.pem",
//             compressors='zlib',
//             zlibCompressionLevel=-1,
//             connect=True,
//         )
//         return client





// $serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);
// $certificateKeyFilePath = '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem';
// $host = nckenowatch.o7lakg5.mongodb.net;
// $port = 27017

// $driver_options = [
//     'authSource' => '$external',
//     'authMechanism' => 'MONGODB-X509',
//     'appName' => 'nckenoWatch',
//     'tlsCertificateKeyFile' => $certificateKeyFilePath,
// ];



// $uri = 'mongodb+srv://' . $host:$port . '/?tlsCertificateKeyFile=' . $certificateKeyFilePath . '&authSource=$external&authMechanism=MONGODB-X509&appName=nckenoWatch&tlsCertificateKeyFile=' . $certificateKeyFilePath;/testdb?authSource=$external&authMechanism=MONGODB-X509



// $serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);
// $certificateKeyFilePath = '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem';
// $host = nckenowatch.o7lakg5.mongodb.net;
// $port = 27017

// $driver_options = [
//     'authSource' => '$external',
//     'authMechanism' => 'MONGODB-X509',
//     'appName' => 'nckenoWatch',
//     'tlsCertificateKeyFile' => $certificateKeyFilePath,
// ];


// $client = new \MongoDB\Client('mongodb+srv://' . "$host:$port/?$driver_options" . ['serverApi' => $serverApi]);
// print_r($client);




// $collection = $client->testDB->testCol;
// $docCount = $collection->countDocuments();
// echo $docCount, "\n";


