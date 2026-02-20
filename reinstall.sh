cd /var/www/pterodactyl || exit

echo "💣 Hapus semua file panel..."
rm -rf .git
rm -rf *

echo "⬇️ Clone ulang official panel..."
git clone https://github.com/pterodactyl/panel.git .
git checkout 1.12.1

echo "📦 Install composer..."
composer install --no-dev --optimize-autoloader

echo "📦 Install node..."
npm install --legacy-peer-deps
npm run build

echo "🧹 Clear cache..."
php artisan view:clear
php artisan config:clear
php artisan cache:clear

echo "🔐 Fix permission..."
chown -R www-data:www-data /var/www/pterodactyl
chmod -R 755 storage bootstrap/cache

systemctl restart nginx
systemctl restart php8.3-fpm

echo "✅ PANEL SUDAH DEFAULT TOTAL"echo "✅ Reinstall selesai!"
echo "📁 Backup database ada di /root/"
