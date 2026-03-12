<!DOCTYPE html>
<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html lang="en" >
<title>
    <? if (isset($title)): ?>
        <?=$title ?>
    <? else: ?>
       <?=$_SERVER['HTTP_HOST']; ?>
    <? endif ?>
</title>
    <head>
      <meta charset="UTF-8">
      <meta name="description" content="Freedom of expression Bazaar">
      <meta name="keywords" content="weed">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" type="text/css" href="http://localhost/webdev/css/fontawesome.min.css">
      <!--link rel="stylesheet" type="text/css" href="http://localhost/webdev/css/w3.css" -->
      <link rel="stylesheet" type="text/css" href="http://localhost/webdev/css/site.css">
      <style>
      </style>
   </head>
     <body>
       <? if($this->isUserLoggedIn()): ?>
       <div class="topnav" id="myTopnav">
         <a href="?c=listings" class="active">Home/Search</a>
         <li><span class="label secondary round account-label">
                 <? if($this->user->is_vendor): ?>
                     <i class="fi-pricetag-multiple" title="This account is a vendor account"></i>
                 <? endif ?>
                 <i class="fi-torso" title="Logged in as <?=$this->e($this->user->name) ?>"></i>
                 <?=$this->e($this->user->name) ?>
             </span>
         </li>
         <div class="topnav-right">
    <div class="dropdown">
    <button class="dropbtn">Orders
      <i class="fas fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="?c=orders&a=index">Current Orders</a>
      <a href="?c=orders&a=history">Order History</a>
    </div>
  </div>
  <div class="dropdown">
    <button class="dropbtn">My Profile
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="?c=orders&a=index">PGP Key</a>
      <a href="?c=orders&a=history">Password and PIN</a>
      <a href="?c=orders&a=history">MultiSig!</a>
    </div>
  </div>
  <a href="?c=users&a=settings">Support</a>
  <a href="?c=users&a=settings">Messages</a>
  <div class="dropdown">
    <button class="dropbtn">Coins
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="#">Link 1</a>
      <a href="#">Link 2</a>
      <a href="#">Link 3</a>
    </div>
  </div>
    <? endif ?>
    <a href="#search">Search</a>
    <a href="#about">About</a>
  </div>
</div>

<?=$content ?>

     </body>
       <footer>
      </footer>
      </html>
