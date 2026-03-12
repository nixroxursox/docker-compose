<?php

require_once('../../vendor/autoload.php');

use MongoDB\Client;
use MongoDB\Driver\Manager;
use MongoDB\Driver\Exception\Exception;
use MongoDB\Driver\ServerApi;

$serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);


class Database
{
    private $client;
    private $db;
    private $collection;
    private $host = 'nckenowatch.o7lakg5.mongodb.net';
    private $port = 27017;
    private $certificateKeyFilePath = '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem';
    private $appName = 'nckenoWatch';
    private $external = true;
    private $authMechanism = 'MONGODB-X509';
    private $uriOptions = [
        'tls' => true,
        'tlsInsecure' => false,
        'tlsAllowInvalidCertificates' => false,
        'tlsCAFile' => '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/ca.pem',
        'tlsCertificateKeyFile' => '/Users/rjallen/ecom/docker_compose/php-8.5/home_dir/certs/X509-cert-gcrUser-0526.pem',
    ];

    public function __construct()
    {
        $this->client = new Client('mongodb+srv://' . $host . ':' . $port . '/?' . "$uriOptions");
    }

    public function get_client  ()
    {
        try  {
            $client = $this->client;
            return $client;
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
        }
    }

}




?>