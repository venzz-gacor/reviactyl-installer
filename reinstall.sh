#!/bin/bash

cd /var/www/pterodactyl || exit

echo "🔐 Backup database..."
DB_NAME=$(grep DB_DATABASE .env | cut -d '=' -f2)
DB_USER=$(grep DB_USERNAME .env | cut -d '=' -f2)
DB_PASS=$(grep DB_PASSWORD .env | cut -d '=' -f2)

mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > /root/pterodactyl_backup_$(date +%F).sql

echo "🔄 Reset panel (hapus tema)..."
git fetch --all
git reset --hard origin/main

echo "📦 Install composer..."
composer install --no-dev --optimize-autoloader

echo "🧹 Clear cache..."
php artisan view:clear
php artisan config:clear
php artisan cache:clear

echo "📦 Install node modules..."
rm -rf node_modules package-lock.json
npm install --legacy-peer-deps
npm run build

echo "🔐 Fix permission..."
chown -R www-data:www-data /var/www/pterodactyl
chmod -R 755 storage bootstrap/cache

echo "🚀 Restart service..."
systemctl restart nginx
systemctl restart php8.3-fpm

echo "✅ Reinstall selesai!"
echo "📁 Backup database ada di /root/"
