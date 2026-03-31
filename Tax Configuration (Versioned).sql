CREATE TABLE tax_slabs (
    id BIGSERIAL PRIMARY KEY,
    effective_from DATE NOT NULL,
    effective_to DATE, -- NULL means current
    slab_order INTEGER NOT NULL,
    lower_bound DECIMAL(12,2) NOT NULL,
    upper_bound DECIMAL(12,2), -- NULL means no upper bound
    fixed_amount DECIMAL(12,2) NOT NULL,
    variable_rate DECIMAL(5,4) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by BIGINT REFERENCES users(id)
);

-- Sample insert for 2025-2026 tax year
INSERT INTO tax_slabs (effective_from, slab_order, lower_bound, upper_bound, fixed_amount, variable_rate) VALUES
('2025-07-01', 1, 0, 600000, 0, 0),
('2025-07-01', 2, 600001, 1200000, 0, 0.01),
('2025-07-01', 3, 1200001, 2200000, 6000, 0.11),
('2025-07-01', 4, 2200001, 3200000, 116000, 0.23),
('2025-07-01', 5, 3200001, 4100000, 346000, 0.30),
('2025-07-01', 6, 4100001, NULL, 616000, 0.35);