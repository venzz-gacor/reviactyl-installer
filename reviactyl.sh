#!/bin/bash

echo "Menginstall Reviactyl Panel..."

cd /var/www/pterodactyl || exit

echo "Download panel..."
curl -Lo panel.tar.gz https://github.com/reviactyl/panel/releases/latest/download/panel.tar.gz

echo "Extract file..."
tar -xzvf panel.tar.gz

echo "Install dependency..."
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader

echo "Update database..."
php artisan migrate --seed --force

echo "Clear cache..."
php artisan view:clear
php artisan config:clear

echo "Restart nginx..."
systemctl restart nginx

echo "Selesai! Reviactyl sudah aktif."
