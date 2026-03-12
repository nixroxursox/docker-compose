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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="font/foundation-icons/foundation-icons.css" />
      <link rel="stylesheet" href="font/font-awesome/font-awesome.min.css">

      <link rel="stylesheet" href="css/normalize.css">
      <link rel="stylesheet" href="css/w3.css">
      <link rel="stylesheet" href="css/foundation.css">
      <link rel="stylesheet" href="css/app.css">
</head>
<body>
<div class="row">
<div class="large-12 columns">
<div class="row">
    <div class="large-12 columns">
        <nav class="top-bar" data-topbar>
            <ul class="title-area">
                <li class="name">
                    <h1><a href="?">
                            <i class="fi-bitcoin"></i>
                            <span class="first">M</span>
                                <span class="title">
                                      <span class="first">9</span>teen
                                    <span class="first">M</span>arket
                                </span>
                        </a></h1>
                </li>
            </ul>
            <? if($this->isUserLoggedIn()): ?>
              <? $this->checkSessionTimeOut(); ?>
                <section class="top-bar-section">
                    <ul class="right">
                        <li><span class="label secondary round account-label">
                                <? if($this->user->is_vendor): ?>
                                    <i class="fi-pricetag-multiple" title="This account is a vendor account"></i>
                                <? endif ?>
                                <i class="fi-torso" title="Logged in as <?=$this->e($this->user->name) ?>"></i>
                                <?=$this->e($this->user->name) ?>
                            </span>
                        </li>
                        <li class="divider"></li>
                        <li<?=$this->controller == 'listings' ? ' class="active"' : ''?>>
                            <a href="?c=listings">Listings</a>
                        </li>
                        <li class="divider"></li>
                        <li<?=$this->controller == 'orders' ? ' class="active"' : ''?>>
                            <a href="?c=orders">Orders</a>
                        </li>
                        <li class="divider"></li>
                        <li class="has-dropdown not-click">
                            <a>Profile</a>
                            <ul class="dropdown">
                                <li><label>General</label></li>
                                <li<?=$this->controller == 'profile' && $this->action == 'settings' ? ' class="active"' : ''?>>
                                    <a href="?c=profile&a=settings">Password and PIN</a>
                                </li>
                                  <li class="divider"></li>
                                <li<?=$this->action == 'pgpkey' ? ' class="active"' : ''?>><a href="?c=profile&a=pgpkey">PGP Key</a></li>
                                <li class="divider"></li>
                                <li<?=$this->action == 'bip32' ? ' class="active"' : ''?>>
                                    <a href="?c=profile&a=bip32">BIP32 configuration</a>
                                </li>
                                <li class="divider"></li>
                                <li><label>Vendor profile</label></li>
                                <? if($this->user->is_vendor): ?>
                                <li>
                                    <a href="?c=listings&a=vendor&u=<?=$this->h($this->user->name, false) ?>">Vendor page</a>
                                </li>
                                <li class="has-dropdown not-click">
                                    <a>Listings</a>
                                    <ul class="dropdown">
                                        <li<?=$this->controller == 'products' ? ' class="active"' : ''?>>
                                            <a href="?c=products">Products</a>
                                        </li>
                                        <li<?=$this->controller == 'shippingOptions' ? ' class="active"' : ''?>>
                                            <a href="?c=shippingOptions">Shipping options</a>
                                        </li>
                                    </ul>
                                </li>
                                <? else: ?>
                                    <li<?=$this->controller == 'profile' && $this->action == 'becomeVendor' ? ' class="active"' : ''?>>
                                        <a href="?c=profile&a=becomeVendor">Become vendor</a>
                                    </li>
                                <? endif ?>
                            </ul>
                        </li>
                        <li class="divider"></li>
                        <li class="has-form">
                            <a href="?c=users&a=logout" class="button alert logout">
                                Logout
                                <i class="fa fa-sign-out"></i>
                            </a>
                        </li>
                    </ul>
                </section>
            <? endif ?>
        </nav>
    </div>
</div>
<div class="row body">

    <?=$content ?>
</div>
<footer class="row">
    <div class="large-12 columns">
        <hr>
        <div class="row">
            <div class="large-6 columns">
                <p>M19</p>
            </div>
            <div class="large-6 columns">
                <ul class="inline-list right">
                    <li>
                        <a href="m19.onion" target="_blank">M19</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>
</div>
</div>
</body>
</html>
