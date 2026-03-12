<?php 

require_once '/code/vendor/autoload.php';

$dbm  =  new MongoDB\Client('mongodb://root:example@localhost:27017/BCMART');


$dbm->captchas; 
$cursor = $dbm->find();

$insertOneResult = $dbm->captchas->insertOne([
	'image'	=> "base64url_encode($image)",
	'code' 	=> "$code",
	'length' => "$length"
	]);

