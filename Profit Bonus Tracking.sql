CREATE TABLE profit_bonus_eligibility (
    id BIGSERIAL PRIMARY KEY,
    employee_id BIGINT NOT NULL REFERENCES employees(id),
    financial_year VARCHAR(9) NOT NULL, -- e.g., '2025-2026'
    days_served_in_year INTEGER NOT NULL,
    is_eligible BOOLEAN GENERATED ALWAYS AS (days_served_in_year >= 90) STORED,
    bonus_amount DECIMAL(12,2),
    payment_date DATE,
    payment_reference VARCHAR(100),
    calculation_method VARCHAR(20), -- FULL or PRO_RATA
    notes TEXT,
    UNIQUE(employee_id, financial_year)
);