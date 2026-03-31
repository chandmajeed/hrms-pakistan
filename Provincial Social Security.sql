CREATE TABLE provincial_social_security (
    id BIGSERIAL PRIMARY KEY,
    employee_id BIGINT NOT NULL REFERENCES employees(id),
    province VARCHAR(50) NOT NULL,
    month_year DATE NOT NULL,
    gross_salary DECIMAL(12,2) NOT NULL,
    wage_ceiling DECIMAL(12,2) NOT NULL, -- Province-specific ceiling
    applicable_amount DECIMAL(12,2) GENERATED ALWAYS AS (LEAST(gross_salary, wage_ceiling)) STORED,
    employer_rate DECIMAL(5,4) NOT NULL, -- 0.06 for 6%
    employer_contribution DECIMAL(12,2) GENERATED ALWAYS AS (applicable_amount * employer_rate) STORED,
    payment_reference VARCHAR(100),
    status VARCHAR(20) DEFAULT 'PENDING',
    UNIQUE(employee_id, month_year)
);