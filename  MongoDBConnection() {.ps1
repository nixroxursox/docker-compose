    public function MongoDBConnection() {
		// $client = New MongoDb\Client(mongodb+srv://nckenowatch.o7lakg5.mongodb.net/?authSource=$external&authMechanism=MONGODB-X509
		//
		$serverApi = new \MongoDB\Driver\ServerApi(\MongoDB\Driver\ServerApi::V1);
                $certificateKeyFilePath = '';
                $client = new \MongoDB\Client(
			'mongodb+srv://nckenowatch.o7lakg5.mongodb.net/?authSource=%24external&authMechanism=MONGODB-X509&appName=nckenoWatch&tlsCertificateKeyFile=' . $certificateKeyFilePath,[], ['serverApi' => $serverApi],);

		$collection = $client->GiftCardReclaim->customer;
                $docCount = $collection->countDocuments();
                echo $docCount, "\n";
		return $client;
                 )
	}