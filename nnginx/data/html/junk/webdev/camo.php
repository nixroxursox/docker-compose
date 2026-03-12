<?php

Class Encode 	{


	public function base64url_encode($data) {
		return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
	}

	public function base64url_decode($data) {
		return base64_decode(str_pad(strtr($data, '-_', '+/'), strlen($data) % 4, '=', STR_PAD_RIGHT));
	}

}



class Captcha {
    /* returns a captcha [code, image]; either from the captcha pool
    or by generating a new one. this is a DoS protection - a malicious user/bot can only
    create max 20 , then he gets back the already existing. If one is solved, it gets deleted from the pool.
    */

		public function base64url_encode($data) {
			return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
		}

		public function base64url_decode($data) {
			return base64_decode(str_pad(strtr($data, '-_', '+/'), strlen($data) % 4, '=', STR_PAD_RIGHT));
		}


    public function get() {
        $captcha = null;
        # create a new unless pool is full
        $poolSize = 20;
        $count = $this->count();
        if($count < $poolSize) {
            $code = $this->create();
            $captcha = [$code, $this->getByCode($code)];
        }
        else {
            # get one from pool if it's full
            $captcha = $this->getRandomCaptcha();
        }
        return $captcha;
    }

    public function check($code, $try) {
        # comparison safe against timing attacks, according to http://stackoverflow.com/questions/25844354/timing-attack-in-php
        $nonce = random_bytes(32);
        $valid = hash_hmac('sha256', $code, $nonce) === hash_hmac('sha256', $try, $nonce);
        if($valid) {
            # captcha solved, remove it
            $this->delete($code);
        }
        return $valid;
    }

    private function delete($code) {
        $q = $this->db->prepare('DELETE FROM captchas WHERE code = :code');
        return $q->execute([':code' => $code]);
    }

    private function getRandomCaptcha() {
			 $col = (new MongoDB\Client)->BCMART->captchas;
			 $out = $col->aggregate($pipeline);
			 var_dump($out);
				//$code = collection.aggregate([{'$sample': {'size': 1 }}])[0])
        return $ret ? [$code, $image] : null;
    }

    private function getByCode($code) {
        $q = $this->db->prepare('SELECT image FROM captchas WHERE code = :code LIMIT 1');
        $image = null;
        $q->bindColumn(1, $image, \PDO::PARAM_LOB);
        $q->execute([':code' => $code]);
        $ret = $q->fetch(\PDO::FETCH_BOUND);
        return $ret ? $image : null;
    }


    private function count() {
			$collection = (new MongoDB\Client)->BCMART->captchas;
			return var_dump($collection->countDocuments());
    }

  public function generate_string($input, $strength = 10) {
     $input_length = strlen($input);
     $random_string = '';
     for($i = 0; $i < $strength; $i++) {
         $random_character = $input[mt_rand(0, $input_length - 1)];
         $random_string .= $random_character;
     }
     return $random_string;
   }
}
	require '/code/vendor/autoload.php';

	function create() {

   $image = imagecreatetruecolor(440, 80);

   imageantialias($image, true);

   $colors = [];
   $red = rand(125, 175);
   $green = rand(125, 175);
   $blue = rand(125, 175);

   for($i = 0; $i < 7; $i++) {
     $colors[] = imagecolorallocate($image, $red - 20*$i, $green - 20*$i, $blue - 20*$i);
   }

   imagefill($image, 0, 0, $colors[0]);

   for($i = 0; $i < 10; $i++) {
     imagesetthickness($image, rand(2, 10));
     $line_color = $colors[rand(1, 4)];
     imagerectangle($image, rand(-10, 450), rand(-10, 10), rand(-10, 450), rand(20, 80), $line_color);
   }

   $black = imagecolorallocate($image, 0, 0, 0);
   $white = imagecolorallocate($image, 255, 255, 255);
   $textcolors = [$black, $white];
   $fonts = array('/code/public/font/Roboto-Light.ttf' ,
          '/code/public/font/Roboto-Regular.ttf' ,
          '/code/public/font/Roboto-ThinItalic.ttf' ,
          '/code/public/font/Roboto-Italic.ttf' ,
          '/code/public/font/Roboto-Bold.ttf' ,
          '/code/public/font/Roboto-Thin.ttf');
   $permitted_chars = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   $string_length = 7;
   $code = Captcha::generate_string($permitted_chars, $string_length);

           for($i = 0; $i < 7; $i++) {
           $letter_space = 200/7;
           $initial = 15;
                                       // orig rand (25 45)
    imagettftext($image, 30, rand(-15, 15), $initial + $i*$letter_space, rand(30, 55), $textcolors[rand(0, 1)], $fonts[array_rand($fonts)], $code[$i]);
    imagettftext($image, 24, 0, imagesx($image)-180, imagesy($image)-20, $line_color, '/code/public/font/Roboto-Regular.ttf', "$_SERVER[HTTP_HOST]");
   }
    header('Content-Encoding: gzip');
    ob_start("ob_gzhandler");
    imagepng($image);
    $img = ob_get_contents();
		$pngimg = Captcha::base64url_encode($img);
    ob_flush();
    imagedestroy($image);


	     try {
				 $collection = (new MongoDB\Client)->BCMART->captchas;
				 $result = $collection->insertOne([
	    		'code' =>  "$code",
	    		'image' => "$pngimg",
				]);
				printf("Inserted %d document(s)\n", $insertOneResult->getInsertedCount());
				var_dump($insertOneResult->getInsertedId());
	    	if(!$result) {
	           throw new \Exception('Error while saving captcha');
	       }
	       return $code;
	     }
	       catch(\Exception $e) {
	           throw $e;
	       }
	     }



Captcha::create() ;
