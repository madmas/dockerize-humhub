# Install cron jobs for user www-data
(crontab -u www-data -l ; echo "30 * * * * /var/www/humhub/protected/yii cron/hourly >/dev/null 2>&1") | crontab -u www-data -
(crontab -u www-data -l ; echo "00 18 * * * /var/www/humhub/protected/yii cron/daily >/dev/null 2>&1") | crontab -u www-data -
echo "Installed cron jobs ..." 