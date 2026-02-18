#!/bin/bash

echo "=== INSTALL TEMA REVIACTLY ==="

PANEL_DIR="/var/www/pterodactyl"

if [ ! -d "$PANEL_DIR" ]; then
  echo "Folder panel tidak ditemukan!"
  exit 1
fi

cd $PANEL_DIR

echo "Backup panel lama..."
cp -r /var/www/pterodactyl /var/www/pterodactyl_backup_$(date +%s)

echo "Maintenance mode..."
php artisan down || true

echo "Download reviactyl..."
curl -Lo panel.tar.gz https://github.com/reviactyl/panel/releases/latest/download/panel.tar.gz
tar -xzvf panel.tar.gz

echo "Install dependency composer..."
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader

echo "Clear cache..."
php artisan view:clear
php artisan config:clear
php artisan cache:clear
php artisan optimize:clear

echo "Migrate database..."
php artisan migrate --seed --force

echo "Fix permission..."
chown -R www-data:www-data /var/www/pterodactyl
chmod -R 755 storage bootstrap/cache

echo "Panel up..."
php artisan up

echo "Restart nginx..."
systemctl restart nginx

echo "=== SELESAI INSTALL REVIACTYL ==="
