# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 is set in /etc/profile, and the default umask is defined
# in /etc/login.defs. You should not need this unless you want different
# defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "$(dircolors)"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
PATH=$PATH:/home/phpUer/bin
MONGODB_URI='mongodb+srv://nckenowatch.o7lakg5.mongodb.net/?authSource=%24external&authMechanism=MONGODB-X509&tls=true&tlsCertificateKeyFile=%2Fhome%2FphpUser%2Fcerts%2FX509-cert-gcrUser-0526.pem&appName=mongosh+2.5.8'
XDEBUG_TRIGGER=1
XDEBUG_SESSION=1
export PATH MONGODB_URI XDEBUG_SESSION XDEBUG_TRIGGER

alias inidir="cd /usr/local/etc/php/conf.d"
alias sodir="cd /usr/local/lib/php/extensions/no-debug-non-zts-20240924"
alias webdir="cd /var/www/html/gcpay_mvc/web/public"
cd /var/www/html/public
