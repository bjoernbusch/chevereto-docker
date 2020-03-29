#!/bin/bash

appdir=/var/www/html
index=$appdir/index.php
apache=/usr/local/bin/apache2-foreground

if [ ! -f $index ]; then
    echo Downloading Chevereto installer
    wget --quiet --output-document=$index https://cdn.rawgit.com/Chevereto/php-repo-installer/master/index.php
    if [ $? -ne 0 ]; then
        echo Could not downolad installer... failing
        exit 1
    fi
    chown www-data:www-data $index
fi

"$settings['session.save_path'] = '/tmp;'" >> /var/www/html/app/settings.php
chown -R www-data:www-data /var/www/html/*

echo "Starting Apache2 ($apache)"
$apache
