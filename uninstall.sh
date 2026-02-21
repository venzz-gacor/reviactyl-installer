#!/bin/bash

echo "🚀 Menghapus Panel + Nginx + Wings..."

# Stop service
systemctl stop nginx mariadb mysql php8.3-fpm php8.2-fpm wings 2>/dev/null
systemctl disable nginx wings 2>/dev/null

# Kill proses
pkill -9 nginx 2>/dev/null

# Hapus nginx
apt purge nginx nginx-common nginx-core -y
apt autoremove --purge -y
apt autoclean -y

# Hapus panel & wings
rm -rf /var/www/pterodactyl
rm -rf /etc/nginx
rm -rf /etc/pterodactyl
rm -f /usr/local/bin/wings
rm -rf /var/log/nginx

# Hapus database default
mysql -u root -e "DROP DATABASE panel; DROP USER 'pterodactyl'@'127.0.0.1'; FLUSH PRIVILEGES;" 2>/dev/null

systemctl daemon-reload

echo "✅ UNINSTALL SELESAI TOTAL"systemctl restart nginx

echo "✅ DONE! Refresh browser CTRL+SHIFT+R"systemctl restart php8.3-fpm 2>/dev/null || \
systemctl restart php8.2-fpm 2>/dev/null || \
systemctl restart php8.1-fpm

systemctl restart nginx

echo "✅ Selesai! Silakan refresh browser (CTRL+SHIFT+R)"
