<?php

class AccessDeniedException extends \Exception {}

function doRegister() {
    # check for existence & format of input params
    accessDeniedUnless(isset($name) && is_string($name) && mb_strlen($name) >= 3);
    accessDeniedUnless(isset($password) && is_string($password) && mb_strlen($password) >= 8);
    accessDeniedUnless(isset($password_confirmation) && is_string($password_confirmation));
    accessDeniedUnless(isset($profile_pin) && is_string($profile_pin) && mb_strlen($profile_pin) >= 4);
    accessDeniedUnless(isset($profile_pin_confirmation) && is_string($profile_pin_confirmation));
    accessDeniedUnless(isset($captcha) && is_string($captcha));
    accessDeniedUnless(isset($_SESSION['captcha_code']));

    $success = false;
    $errorMessage = '';

    //$user = getModel('User');

    if($captcha === $_SESSION['captcha_code']){
        unset($_SESSION['captcha_code']);
        # check that $name is not emtpy or taken...
        if(($name)) {
            # ... that $password match
            if($password === $password_confirmation) {
                # ... profile pins match
                if($profile_pin === $profile_pin_confirmation) {
                    # save in database
                    if ($user->register($name, $password, $profile_pin)) {
                        $success = true;
                    } else {
                        $errorMessage = 'Could not register due to unknown error.';
                    }
                }
                else {
                    $errorMessage = 'Profile PINs did not match.';
                }
            }
            else {
                $errorMessage = '$password did not match.';
            }
        }
        else {
            $errorMessage = '$name already taken.';
        }
      }
    else {
        $errorMessage = 'Captcha wrong.';
    }
}

$name = 'user6';
$password = '55555555';
$password_confirmation = '55555555';
$profile_pin = '55555555';
$profile_pin_confirmation = '55555555';
$_SESSION['captcha_code'] = '1234567';
$captcha = '1234567';

doRegister($name,$password,$password_confirmation,$profile_pin,$profile_pin_confirmation,$captcha,$_SESSION['captcha_code']);
