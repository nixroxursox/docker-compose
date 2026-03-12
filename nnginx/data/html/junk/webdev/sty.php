<?php

Class Crypto   {


    private $cjt;
    private $task;
    public $msg;

    protected function __construct($msg)  {

      $key   = random_bytes(SODIUM_CRYPTO_SECRETBOX_KEYBYTES);
      $nonce = random_bytes(SODIUM_CRYPTO_SECRETBOX_NONCEBYTES);

      if  (! $ciphertext = sodium_crypto_secretbox($msg, $nonce, $key)) {
        $e = new \Exception();
        throw  $e;
      } else {
        return $this->$ciphertext;
      }
  }
}

$msg = "hello world";
$test = new Crypto($msg);

var_dump($test);
/*
// Generating an encryption key and a nonce
$key   = random_bytes(SODIUM_CRYPTO_SECRETBOX_KEYBYTES);
$nonce = random_bytes(SODIUM_CRYPTO_SECRETBOX_NONCEBYTES); // 24 bytes

// Encrypt
$ciphertext = sodium_crypto_secretbox($msg, $nonce, $key);

echo "$ciphertext" . "\n";
echo "$key" . "\n";
echo "$nonce" . "\n";

// Decrypt
$plaintext = sodium_crypto_secretbox_open($ciphertext, $nonce, $key);

echo $plaintext === $msg ? 'Success' : 'Error';

//break

$msg = 'This is the message to authenticate!';
$key = random_bytes(SODIUM_CRYPTO_SECRETBOX_KEYBYTES); // 256 bit

// Generate the Message Authentication Code
$mac = sodium_crypto_auth($msg, $key);

// Altering $mac or $msg, verification will fail
echo sodium_crypto_auth_verify($mac, $msg, $key) ? 'Success' : 'Error';

//break
$msg = 'This is the message to authenticate!';
$key = random_bytes(SODIUM_CRYPTO_SECRETBOX_KEYBYTES); // 256 bit

// Generate the Message Authentication Code
$mac = sodium_crypto_auth($msg, $key);

// Altering $mac or $msg, verification will fail
echo sodium_crypto_auth_verify($mac, $msg, $key) ? 'Success' : 'Error';

$aliceKeypair = sodium_crypto_box_keypair();
$alicePublicKey = sodium_crypto_box_publickey($aliceKeypair);
$aliceSecretKey = sodium_crypto_box_secretkey($aliceKeypair);

$bobKeypair = sodium_crypto_box_keypair();
$bobPublicKey = sodium_crypto_box_publickey($bobKeypair); // 32 bytes
$bobSecretKey = sodium_crypto_box_secretkey($bobKeypair); // 32 bytes

//break
$msg = 'Hi Bob, this is Alice!';
$nonce = random_bytes(SODIUM_CRYPTO_BOX_NONCEBYTES); // 24 bytes

$keyEncrypt = $aliceSecretKey . $bobPublicKey;
$ciphertext = sodium_crypto_box($msg, $nonce, $keyEncrypt);

$keyDecrypt = $bobSecretKey . $alicePublicKey;
$plaintext = sodium_crypto_box_open($ciphertext, $nonce, $keyDecrypt);
echo $plaintext === $msg ? 'Success' : 'Error';

$keypair = sodium_crypto_sign_keypair();
$publicKey = sodium_crypto_sign_publickey($keypair); // 32 bytes
$secretKey = sodium_crypto_sign_secretkey($keypair); // 64 bytes

//break
$msg = 'This message is from Alice';
// Sign a message
$signedMsg = sodium_crypto_sign($msg, $secretKey);
// Or generate only the signature (detached mode)
$signature = sodium_crypto_sign_detached($msg, $secretKey); // 64 bytes

// Verify the signed message
$original = sodium_crypto_sign_open($signedMsg, $publicKey);
echo $original === $msg ? 'Signed msg ok' : 'Error signed msg';
// Verify the signature
echo sodium_crypto_sign_verify_detached($signature, $msg, $publicKey) ?
     'Signature ok' : 'Error signature';
// break
     if (! sodium_crypto_aead_aes256gcm_is_available()) {
         throw new \Exception("AES-GCM is not supported on this platform");
     }
     $msg = 'Super secret message!';
     $key = random_bytes(SODIUM_CRYPTO_AEAD_AES256GCM_KEYBYTES);
     $nonce = random_bytes(SODIUM_CRYPTO_AEAD_AES256GCM_NPUBBYTES);

     // AEAD encryption
     $ad = 'Additional public data';
     $ciphertext = sodium_crypto_aead_aes256gcm_encrypt(
         $msg,
         $ad,
         $nonce,
         $key
     );
     // AEAD decryption
     $decrypted = sodium_crypto_aead_aes256gcm_decrypt(
         $ciphertext,
         $ad,
         $nonce,
         $key
     );
     echo "$decrypted";

     if ($decrypted === false) {
         throw new \Exception("Decryption failed");
     }
     echo $decrypted === $msg ? 'OK' : 'Error';

}*/
