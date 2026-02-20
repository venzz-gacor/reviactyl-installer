#!/bin/bash

echo "🚀 Uninstalling Reviactly Theme..."

cd /var/www/pterodactyl || { echo "❌ Folder tidak ditemukan"; exit 1; }

# Hapus sisa tema
rm -rf resources/views/vendor/reviactly
rm -rf public/themes/reviactly
rm -rf resources/scripts/components/reviactly
rm -rf resources/scripts/assets/reviactly

# Reset panel
git fetch --all
git reset --hard origin/$(git branch --show-current 2>/dev/null || echo main) || git reset --hard
git pull

# Install composer
composer install --no-dev --optimize-autoloader

# Clear cache
php artisan view:clear
php artisan config:clear
php artisan cache:clear
php artisan route:clear

# Build ulang frontend
rm -rf node_modules package-lock.json
npm install --legacy-peer-deps
npm run build

# Fix permission
chown -R www-data:www-data /var/www/pterodactyl
chmod -R 755 /var/www/pterodactyl

# Restart PHP otomatis (deteksi versi)
systemctl restart php8.3-fpm 2>/dev/null || \
systemctl restart php8.2-fpm 2>/dev/null || \
systemctl restart php8.1-fpm

systemctl restart nginx

echo "✅ Selesai! Silakan refresh browser (CTRL+SHIFT+R)"
