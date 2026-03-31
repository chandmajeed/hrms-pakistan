CREATE TABLE compliance_calendar (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES companies(id),
    obligation_type VARCHAR(50) NOT NULL, -- INCOME_TAX_MONTHLY, EOBI_MONTHLY, PESSI_MONTHLY, ANNUAL_RETURN
    due_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    filed_date DATE,
    filing_reference VARCHAR(100),
    amount_paid DECIMAL(15,2),
    reminder_sent BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);