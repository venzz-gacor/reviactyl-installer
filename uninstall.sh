#!/bin/bash

echo "🚀 FORCE CLEAN REVIACTLY..."

cd /var/www/pterodactyl || { echo "❌ Folder tidak ditemukan"; exit 1; }

echo "🧹 Hapus semua sisa tema..."
rm -rf resources/views/vendor/reviactly
rm -rf public/themes/reviactly
rm -rf resources/scripts/components/reviactly
rm -rf resources/scripts/assets/reviactly

echo "💥 Bersihkan file modifikasi..."
git reset --hard
git clean -fd

echo "📦 Install ulang dependency..."
composer install --no-dev --optimize-autoloader

echo "🧼 Clear cache..."
php artisan optimize:clear

echo "🧱 Build ulang frontend..."
rm -rf node_modules package-lock.json
npm install --legacy-peer-deps
npm run build

echo "🔐 Fix permission..."
chown -R www-data:www-data /var/www/pterodactyl
chmod -R 755 /var/www/pterodactyl

echo "🔄 Restart service..."
systemctl restart php8.3-fpm 2>/dev/null || \
systemctl restart php8.2-fpm 2>/dev/null || \
systemctl restart php8.1-fpm

systemctl restart nginx

echo "✅ DONE! Refresh browser CTRL+SHIFT+R"systemctl restart php8.3-fpm 2>/dev/null || \
systemctl restart php8.2-fpm 2>/dev/null || \
systemctl restart php8.1-fpm

systemctl restart nginx

echo "✅ Selesai! Silakan refresh browser (CTRL+SHIFT+R)"
