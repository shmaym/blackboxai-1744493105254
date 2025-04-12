# Forex Analytics AI

Real-time forex analysis with AI-powered insights and TradingView charts.

## Features

- Real-time forex charts via TradingView integration
- Multiple technical indicators (RSI, MACD, MA, Bollinger Bands)
- AI-powered market analysis
- Detailed trading recommendations
- Support and resistance level detection

## Secure Deployment Instructions

### Prerequisites

- Ubuntu/Debian server
- Node.js 18.x or higher
- Nginx
- PM2 (installed automatically during setup)

### Security First Steps

1. Create a new sudo user (DO NOT use root):
```bash
sudo adduser deploy
sudo usermod -aG sudo deploy
```

2. Switch to the new user:
```bash
su - deploy
```

### Application Setup

1. Clone the repository to your local machine:
```bash
git clone <repository-url>
cd forex-analytics-ai
```

2. Install dependencies:
```bash
npm run setup
```

3. Make the deployment script executable:
```bash
chmod +x deploy.sh
```

4. Run the deployment script:
```bash
./deploy.sh
```

### Post-Deployment

1. Verify the application is running:
```bash
pm2 status
```

2. Check the application logs:
```bash
pm2 logs forex-analytics-ai
```

3. Monitor the application:
```bash
pm2 monit
```

### Security Recommendations

1. Enable firewall:
```bash
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
```

2. Install and configure SSL certificate:
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx
```

3. Regular updates:
```bash
sudo apt update
sudo apt upgrade
```

### Maintenance

- To start the application: `npm run start:prod`
- To stop the application: `npm run stop:prod`
- To view logs: `pm2 logs forex-analytics-ai`
- To restart: `pm2 restart forex-analytics-ai`

## Application Structure

```
forex-analytics-ai/
├── server.js           # Express server
├── ecosystem.config.js # PM2 configuration
├── index.html         # Main landing page
├── chart.html        # TradingView chart page
├── report.html       # AI analysis report page
└── deploy.sh         # Deployment script
```

## Environment Variables

The application uses the following environment variables in production:

- `NODE_ENV`: Set to 'production'
- `PORT`: Default is 8000

## Security Notes

1. Never run the application as root
2. Always use HTTPS in production
3. Keep Node.js and npm packages updated
4. Regularly monitor logs for suspicious activity
5. Implement rate limiting for API endpoints
6. Use secure WebSocket connections for real-time data

## Troubleshooting

If you encounter issues:

1. Check application logs: `pm2 logs forex-analytics-ai`
2. Verify Nginx configuration: `sudo nginx -t`
3. Check Nginx logs: `sudo tail -f /var/log/nginx/error.log`
4. Ensure proper permissions: `ls -la /var/www/forex-analytics-ai`

## Support

For issues or questions, please open a GitHub issue or contact support.
