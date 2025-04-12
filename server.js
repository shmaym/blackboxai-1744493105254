const express = require('express');
const path = require('path');
const app = express();
const port = 8000;

// Middleware for parsing JSON and serving static files
app.use(express.json());
app.use(express.static(path.join(__dirname)));

// Routes
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/chart', (req, res) => {
    res.sendFile(path.join(__dirname, 'chart.html'));
});

app.get('/report', (req, res) => {
    res.sendFile(path.join(__dirname, 'report.html'));
});

// API endpoint for analysis
app.post('/api/analyze', (req, res) => {
    const { pair, timeframe, indicators } = req.body;
    
    // Simulate AI analysis with random data
    const analysis = {
        pair,
        timeframe,
        timestamp: new Date().toISOString(),
        trend: Math.random() > 0.5 ? 'bullish' : 'bearish',
        confidence: Math.floor(Math.random() * 30 + 70),
        support: (Math.random() * 2 + 1).toFixed(4),
        resistance: (Math.random() * 2 + 1.5).toFixed(4),
        indicators: indicators ? indicators.map(ind => ({
            name: ind,
            signal: Math.random() > 0.5 ? 'buy' : 'sell',
            strength: Math.floor(Math.random() * 100)
        })) : []
    };

    res.json(analysis);
});

// Catch-all route to handle direct HTML file requests
app.get('*.html', (req, res) => {
    res.sendFile(path.join(__dirname, req.path));
});

// Start server
app.listen(port, '0.0.0.0', () => {
    console.log(`Server running at http://localhost:${port}`);
});
