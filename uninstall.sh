systemctl stop nginx apache2 mariadb mysql wings php8.3-fpm php8.2-fpm 2>/dev/null && \
systemctl disable nginx apache2 wings 2>/dev/null && \
systemctl mask nginx apache2 2>/dev/null && \
pkill -9 nginx 2>/dev/null && \
pkill -9 apache2 2>/dev/null && \
apt purge nginx* apache2* -y && \
apt purge pterodactyl* -y 2>/dev/null && \
apt autoremove --purge -y && \
rm -rf /var/www/pterodactyl && \
rm -rf /etc/nginx && \
rm -rf /etc/apache2 && \
rm -rf /etc/pterodactyl && \
rm -rf /var/log/nginx && \
rm -f /usr/local/bin/wings && \
rm -f /lib/systemd/system/wings.service && \
systemctl daemon-reload && \
echo "🔥 BERSIH TOTAL 🔥"
