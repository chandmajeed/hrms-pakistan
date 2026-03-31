CREATE TABLE eobi_contributions (
    id BIGSERIAL PRIMARY KEY,
    employee_id BIGINT NOT NULL REFERENCES employees(id),
    month_year DATE NOT NULL, -- First day of month (e.g., '2026-01-01')
    employer_contribution DECIMAL(12,2) NOT NULL, -- 5% of 40,000 = 2,000
    employee_contribution DECIMAL(12,2) NOT NULL, -- 1% of 40,000 = 400
    total_contribution DECIMAL(12,2) GENERATED ALWAYS AS (employer_contribution + employee_contribution) STORED,
    payment_reference VARCHAR(100),
    payment_date DATE,
    status VARCHAR(20) DEFAULT 'PENDING', -- PENDING, PAID, FAILED
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(employee_id, month_year)
);

CREATE TABLE eobi_monthly_returns (
    id BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES companies(id),
    month_year DATE NOT NULL,
    total_employees_covered INTEGER NOT NULL,
    total_employer_contribution DECIMAL(12,2) NOT NULL,
    total_employee_contribution DECIMAL(12,2) NOT NULL,
    filing_date DATE,
    filing_reference VARCHAR(100),
    status VARCHAR(20) DEFAULT 'DRAFT',
    submitted_by BIGINT REFERENCES users(id),
    submitted_at TIMESTAMP,
    UNIQUE(company_id, month_year)
);