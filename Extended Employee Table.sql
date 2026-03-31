CREATE TABLE employees (
    id BIGSERIAL PRIMARY KEY,
    -- Pakistan specific identifiers
    cnic VARCHAR(13) UNIQUE NOT NULL,  -- 13 digits without spaces
    ntn VARCHAR(20),                    -- National Tax Number
    eobi_registration_number VARCHAR(50),
    provincial_work_location VARCHAR(50) NOT NULL, -- Punjab, Sindh, KP, Balochistan, ICT
    employment_type VARCHAR(30) NOT NULL, -- Permanent, Probationary, Contract, Temporary, Apprentice, Substitute
    
    -- Service tracking
    date_of_first_employment DATE NOT NULL,
    probation_start_date DATE,
    probation_end_date DATE,
    is_probation_completed BOOLEAN DEFAULT FALSE,
    
    -- Compliance flags
    zakat_consent BOOLEAN DEFAULT FALSE,
    zakat_consent_reference VARCHAR(100),
    is_person_with_disability BOOLEAN DEFAULT FALSE,
    disability_certificate_reference VARCHAR(100),
    
    -- Legal status
    is_contract_worker BOOLEAN DEFAULT FALSE,
    principal_employer_id BIGINT REFERENCES companies(id), -- for contract workers
    
    -- Foreign keys
    company_id BIGINT NOT NULL REFERENCES companies(id),
    branch_id BIGINT REFERENCES branches(id),
    department_id BIGINT REFERENCES departments(id),
    manager_id BIGINT REFERENCES employees(id),
    user_account_id BIGINT REFERENCES users(id),
    
    -- Personal details
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    father_name VARCHAR(100),
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    marital_status VARCHAR(20),
    
    -- Contact
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    mobile VARCHAR(20),
    emergency_contact JSONB,
    
    -- Employment
    joining_date DATE NOT NULL,
    confirmation_date DATE,
    resignation_date DATE,
    
    -- Financial
    bank_account JSONB, -- { bank_name, account_title, account_number, iban }
    salary_structure JSONB NOT NULL,
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    created_by BIGINT REFERENCES users(id)
);

CREATE INDEX idx_employees_cnic ON employees(cnic);
CREATE INDEX idx_employees_eobi_reg ON employees(eobi_registration_number);
CREATE INDEX idx_employees_company_province ON employees(company_id, provincial_work_location);