<?php


class NewCaptcha {

	    protected $code;
	    protected $width = '190';
	    protected $height = '60';
      protected $string_length = '5';


	function __construct() {
	         $string_length = 5;
        	 $permitted_chars = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		        //$this->code = substr(sha1(mt_rand()), 17, 6);
		       $this->code = $this->generate_string($permitted_chars, $string_length);
	}

	private function generate_string($input, $strength = 10) {
		 $input_length = strlen($input);
		 $random_string = '';
		 for($i = 0; $i < $strength; $i++) {
				 $random_character = $input[mt_rand(0, $input_length - 1)];
				 $random_string .= $random_character;
		 }
		 return $random_string;
	 }

	public function getCode()
	{
		return $this->code;
	}

	public function showImage()
	{
		$image = imagecreatetruecolor($this->width, $this->height);

		$width = imagesx($image);
		$height = imagesy($image);

		imageantialias($image, true);

    $colors = [];
    $red = rand(125, 175);
    $green = rand(125, 175);
    $blue = rand(125, 175);

    for($i = 0; $i < 5; $i++) {
      $colors[] = imagecolorallocate($image, $red - 20*$i, $green - 20*$i, $blue - 20*$i);
    }

    imagefill($image, 0, 0, $colors[0]);

    for($i = 0; $i < 10; $i++) {
      imagesetthickness($image, rand(2, 10));
      $line_color = $colors[rand(1, 4)];
			// originally -10 - 190 //  40 - 60 at the  end
      imagerectangle($image, rand(-10, 190), rand(-10, 10), rand(-10, 190), rand(20, 60), $line_color);
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

            for($i = 0; $i < 5; $i++) {
            $letter_space = 180/5;
            $initial = 10;

							//originally  24 below
      imagettftext($image, 26, rand(-15, 15), $initial + $i*$letter_space, rand(25, 45), $textcolors[rand(0, 1)], $fonts[array_rand($fonts)], $this->code[$i]);
    }

	//	imagestring($image, 10, intval(($width - (strlen($this->code) * 9)) / 2),  intval(($height - 15) / 2), $this->code, $black);

		header('Content-type: image/png');

		imagepng($image);
		imagedestroy($image);

	}

}
$captcha = new newCaptcha();

$captcha->showImage();
