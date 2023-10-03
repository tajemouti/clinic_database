-= Creating a database with name clinic
CREATE DATABASE clinic

-- Creating a basic database table for a clinic's patients.
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL
);

-- Creating a "medical_histories" table with the specified columns.
CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIME NOT NULL,
    patient_id INTEGER NOT NULL,
    status VARCHAR(255)
);

--Creating a foreign key relationship between the "medical_histories" table and the "patients" table.
ALTER TABLE medical_histories
ADD CONSTRAINT fk_patient_id
FOREIGN KEY (patient_id)
REFERENCES patients(id);

-- Creating a "treatment" table with the specified columns;
CREATE TABLE treatment (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

-- Creating a table named "medical_history_treatment" that relates to both the "medical_histories" table and the "treatment" table( a junction table). 
-- This junction table will store the relationships between medical histories and treatments using their respective IDs.
CREATE TABLE medical_history_treatments (
    id SERIAL PRIMARY KEY,
    medical_history_id INTEGER NOT NULL,
    treatment_id INTEGER NOT NULL,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatment_id) REFERENCES treatment(id)
);

-- Create the invoices' table.
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL NOT NULL,
    genarated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT
);

-- Create foreign key for invoices.
ALTER TABLE invoices
ADD CONSTRAINT fk_invoice_id
FOREIGN KEY (medical_history_id)
REFERENCES medical_histories (id);

-- Create the invoice_items junction table.
CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL NOT NULL,
    quatity INT NOT NULL,
    total_price DECIMAL NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL
);

--Create foreign keys for invoice_items.
ALTER TABLE invoice_items
ADD CONSTRAINT fk_invoice_items_invoice_id
FOREIGN KEY (invoice_id)
REFERENCES invoices (id),
ADD CONSTRAINT fk_invoice_items_treatment_id
FOREIGN KEY (treatment_id)
REFERENCES treatments (id);

-- Add FK indexes for the medical_histories, medical_history_treatments, invoices and invoice_items tables.
CREATE INDEX idx_fk_patient_id ON medical_histories (patient_id);

CREATE INDEX idx_fk_medical_history_id ON medical_history_treatments (medical_history_id);
CREATE INDEX idx_fk_treatment_id ON medical_history_treatments (treatment_id);

CREATE INDEX idx_fk_medical_history_id ON invoices (medical_history_id);

CREATE INDEX idx_fk_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_fk_treatment_id ON invoice_items (treatment_id);
