<?php

//77         namespace M19;

Class MDB {

    function __construct()  {
        require '/code/vendor/autoload.php';
        return $this->mdb = new MongoDB\Driver\Manager('mongodb://root:example@localhost/admin');
    }
}

$mgr = new MDB();
var_dump($mgr);
