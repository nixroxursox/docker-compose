<?php

//namespace M19;

Class Mongo	{


	private $mongohost = 'localhost';

	function __construct($dbh) {
require_once '/code/vendor/autoload.php';
		return $this->dbh = new MongoDB\Client();
		}
}

$dbh = new Mongo('mongodb://root:example@localhost:27017/BCMART');

$dbh->test;




