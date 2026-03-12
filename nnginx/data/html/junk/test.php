<?php

require_once('../app/test');

$key = sodium_randombytes_buf(CRYPTO_AEAD_CHACHA20POLY1305_KEYBYTES);
$nonce = sodium_randombytes_buf(CRYPTO_AEAD_CHACHA20POLY1305_NPUBBYTES);
$message = "Hi Sexy - message \n";
$ad = 'Additional xxxxx data';
$ciphertext = sodium_crypto_aead_chacha20poly1305_encrypt(
    $message,
    $ad,
    $nonce,
    $key
);

echo "$cyphertext" . "\n";
