<?php



require_once '/code/public/aerospike.php';

$adb = new ASDB::get();


$key = $adb->initKey("m19", "Captchas", 1234);

// the record and its bins are created and updated similar to an array
$put_vals = [ "name" => "Scruffy", "Occupation" => "The Janitor" ];
$adb->put($key, $put_vals);

// record bins can hold complex types such as arrays
$update_vals = [
  "quotes" => [
    "I'm Scruffy. The janitor.",
    "I'm on break.",
    "Scruffy's gonna die like he lived."]];
$adb->put($key, $update_vals);

// read selected bins from a record
$adb->get($key, $record, ["name", "quotes"]);
