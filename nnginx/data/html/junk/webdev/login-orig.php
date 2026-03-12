<?php $title = 'Login | '.$_SERVER['HTTP_HOST'] ?>

<div class="large-8 large-offset-2 columns">
    <? if(isset($error)): ?>
        <div data-alert class="alert-box alert">
            <?=$this->e($error) ?>
        </div>
    <? endif ?>
    <? if($this->fl('success')): ?>
        <div data-alert class="alert-box success">
            <?=$this->fl('success') ?>
        </div>
    <? endif ?>

    <div id="login-logo-wrapper">
        <img src="">
    </div>

    <form action="?c=users&a=doLogin" method="post">
        <div class="row collapse">
            <div class="large-4 large-offset-2 columns">
                <span class="prefix">Username</span>
            </div>
            <div class="large-5 columns end">
                <input type="text" name="name" placeholder="Choose a unique username" required="true" autocomplete="off">
            </div>
        </div>
        <div class="row collapse">
            <div class="large-4 large-offset-2 columns">
                <span class="prefix">Password</span>
            </div>
            <div class="large-5 columns end">
                <input type="password" name="password" placeholder="Choose a secure password" required="true" autocomplete="off">
            </div>
        </div>

        <div class="row collapse">
            <div class="large-12 columns end" align="center">
                <img src="?c=users&a=captcha">
            </div>
            <div class="large-12 columns end">
                <input type="text" name="captcha" placeholder="captcha" required="true" autocomplete="off" class="captcha" maxlength="7">
            </div>
        </div>

        <div class="row collapse">
            <div class="large-9 large-offset-2 columns">
                <input type="submit" value="Login" class="button expand success" />
            </div>
        </div>
        <div class="row collapse">
            <div class="large-8 large-offset-2 columns text-center">
                <a href="?c=users&a=register">Register</a>
            </div>
        </div>
</div>
<div class="large-2 columns"></div>
