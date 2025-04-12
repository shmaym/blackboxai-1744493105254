#!/bin/bash

# Create application directory
mkdir -p /var/www/forex-analytics-ai

# Create non-root user for the application
sudo useradd -r -s /bin/false forex-app

# Set proper ownership and permissions
sudo chown -R forex-app:forex-app /var/www/forex-analytics-ai
sudo chmod -R 755 /var/www/forex-analytics-ai

# Install Node.js and npm if not already installed
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# Install PM2 globally
sudo npm install -g pm2

# Copy application files
cp -r ./* /var/www/forex-analytics-ai/

# Install dependencies
cd /var/www/forex-analytics-ai
npm install --production

# Setup PM2 to run as forex-app user
sudo -u forex-app pm2 start ecosystem.config.js

# Setup PM2 to start on system boot
sudo -u forex-app pm2 startup
sudo -u forex-app pm2 save

# Setup Nginx reverse proxy
sudo tee /etc/nginx/sites-available/forex-analytics-ai << EOF
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:8000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Enable the Nginx site
sudo ln -s /etc/nginx/sites-available/forex-analytics-ai /etc/nginx/sites-enabled/

# Test Nginx configuration
sudo nginx -t

# Reload Nginx
sudo systemctl reload nginx

echo "Deployment completed successfully!"
