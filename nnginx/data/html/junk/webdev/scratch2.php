<?php




$arr = array("Orders", "Listings", "Support", "Messages", "Vendor", "Users");foreach ($arr as $x)  {echo "<li <?=$this->controller == \"$x\" ? \' class=\"active w3-bg-dark\"\' : \'\'?>><a href=\"?c=\"$x\">\"$x\"</a></li>";
