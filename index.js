// backend/index.js
const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 8080;

// Middleware
app.use(cors());
app.use(express.json());

// Initialize Supabase client
const supabase = createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_ANON_KEY
);

// Health check endpoint - tests database connection
app.get('/api/health', async (req, res) => {
    try {
        // Test database connection
        const { data, error } = await supabase
            .from('employees')
            .select('count')
            .limit(1);
            
        if (error) throw error;
        
        res.json({ 
            status: 'healthy', 
            database: 'connected',
            message: 'HRMIS Pakistan API is running'
        });
    } catch (error) {
        res.status(500).json({ 
            status: 'unhealthy', 
            database: 'disconnected',
            error: error.message 
        });
    }
});

// Test endpoint for payroll calculation (Pakistan specific)
app.get('/api/test-tax', (req, res) => {
    const monthlySalary = 100000; // PKR 100,000
    
    // Simple tax calculation for demonstration
    const annualSalary = monthlySalary * 12;
    let annualTax = 0;
    
    if (annualSalary > 600000) {
        if (annualSalary <= 1200000) {
            annualTax = (annualSalary - 600000) * 0.01;
        } else if (annualSalary <= 2200000) {
            annualTax = 6000 + (annualSalary - 1200000) * 0.11;
        } else if (annualSalary <= 3200000) {
            annualTax = 116000 + (annualSalary - 2200000) * 0.23;
        } else {
            annualTax = 346000 + (annualSalary - 3200000) * 0.30;
        }
    }
    
    const monthlyTax = annualTax / 12;
    
    res.json({
        monthly_salary_pkr: monthlySalary,
        annual_tax_pkr: annualTax,
        monthly_tax_pkr: monthlyTax,
        tax_year: "2025-2026"
    });
});

// Start server
app.listen(PORT, () => {
    console.log(`HRMIS Pakistan API running on port ${PORT}`);
    console.log(`Health check: http://localhost:${PORT}/api/health`);
});
