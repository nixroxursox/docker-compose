<?php
$menuLiList = array("Orders", "Listings", "Support", "Messages", "Vendor", "Users");

$i = 1;

foreach($menuLinks as $link => $label){
    /**
     * if $i is 1, add current class to the li, i.e. add current class to the first element.
     **/
    $current = $i == 1 ? 'class="current"' : '';
    /**
     * append html
     **/
    $menuLiList .= '<li  '.$current.'><a href="'.$link.$i.'">'.$label.'</a></li>';
    /**
     * increase counter.
     **/
    $i++;
}
/**
 * Finally, echo what you have in list, plus the outer wrapper.
 **/
echo '<nav>
<div id="topnav">
    <ul id="nav">
        '.$menuLiList.'
    </ul>
</div>
</nav>';