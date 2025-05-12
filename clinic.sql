-- Clinic Booking System Database
-- MySQL Database Schema

DROP DATABASE IF EXISTS clinic;

-- Create the database
CREATE DATABASE clinic;
USE clinic;

-- DepartmentS table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    location VARCHAR(200)
);

-- Doctors table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department_id INT,
    specialization VARCHAR(100) NOT NULL,
    qualifications TEXT,
    hire_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address TEXT,
    blood_group VARCHAR(5),
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20)
);

-- Insurance Providers Table
CREATE TABLE InsuranceProviders (
    provider_id INT PRIMARY KEY AUTO_INCREMENT,
    provider_name VARCHAR(100) NOT NULL UNIQUE,
    contact_number VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

-- Patient Insurance Table (Many-to-Many Relationship)
CREATE TABLE PatientInsurance (
    patient_id INT,
    provider_id INT,
    policy_number VARCHAR(50) NOT NULL,
    coverage_amount DECIMAL(10,2),
    expiry_date DATE,
    PRIMARY KEY (patient_id, provider_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES InsuranceProviders(provider_id)
);

-- Appointment Slots Table
CREATE TABLE AppointmentSlots (
    slot_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    available_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_booked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    UNIQUE KEY unique_slot (doctor_id, available_date, start_time)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    slot_id INT NOT NULL UNIQUE,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'Rescheduled') DEFAULT 'Scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (slot_id) REFERENCES AppointmentSlots(slot_id)
);

-- Medical Records Table
CREATE TABLE MedicalRecords (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT,
    diagnosis TEXT,
    prescription TEXT,
    treatment_plan TEXT,
    medical_notes TEXT,
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Billing Table
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    appointment_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    paid_amount DECIMAL(10,2) DEFAULT 0,
    payment_status ENUM('Unpaid', 'Partially Paid', 'Fully Paid') DEFAULT 'Unpaid',
    billing_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_date DATETIME,
    payment_method ENUM('Cash', 'Credit Card', 'Debit Card', 'Insurance', 'Online Transfer'),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Indexes for Performance Optimization
CREATE INDEX idx_patient_name ON Patients(last_name, first_name);
CREATE INDEX idx_doctor_name ON Doctors(last_name, first_name);
CREATE INDEX idx_appointment_date ON Appointments(appointment_date);
CREATE INDEX idx_medical_record_patient ON MedicalRecords(patient_id);


-- Insert Departments
INSERT INTO Departments (department_name, description, location) VALUES 
('Cardiology', 'Heart and Blood Vessel Treatment', 'Wing A, 1st Floor'),
('Neurology', 'Brain and Nervous System Treatment', 'Wing B, 2nd Floor'),
('Orthopedics', 'Bone and Joint Specialist', 'Wing C, Ground Floor'),
('Pediatrics', 'Child Healthcare', 'Wing D, 2nd Floor'),
('Oncology', 'Cancer Treatment', 'Wing E, 3rd Floor');

-- Insert Doctors
INSERT INTO Doctors (first_name, last_name, email, phone, department_id, specialization, qualifications, hire_date) VALUES 
('John', 'Smith', 'john.smith@clinic.com', '555-1234', 1, 'Cardiologist', 'MD, Cardiology, Harvard Medical School', '2020-01-15'),
('Emily', 'Johnson', 'emily.johnson@clinic.com', '555-5678', 2, 'Neurologist', 'MD, Neurology, Stanford Medical Center', '2019-05-20'),
('Michael', 'Williams', 'michael.williams@clinic.com', '555-9012', 3, 'Orthopedic Surgeon', 'MD, Orthopedics, Johns Hopkins', '2018-11-10'),
('Sarah', 'Brown', 'sarah.brown@clinic.com', '555-3456', 4, 'Pediatrician', 'MD, Pediatrics, Mayo Clinic', '2021-03-01'),
('David', 'Miller', 'david.miller@clinic.com', '555-7890', 5, 'Oncologist', 'MD, Oncology, MD Anderson Cancer Center', '2017-07-22');

-- Insert Insurance Providers
INSERT INTO InsuranceProviders (provider_name, contact_number, email, address) VALUES 
('HealthGuard Insurance', '800-123-4567', 'support@healthguard.com', '123 Insurance Blvd, New York, NY 10001'),
('MediCare Plus', '888-987-6543', 'contact@medicareplus.com', '456 Health Street, Chicago, IL 60601'),
('Wellness Coverage', '877-456-7890', 'info@wellnesscoverage.com', '789 Wellness Ave, Los Angeles, CA 90001');

-- Insert Patients
INSERT INTO Patients (first_name, last_name, date_of_birth, gender, email, phone, address, blood_group, emergency_contact_name, emergency_contact_phone) VALUES 
('Robert', 'Garcia', '1975-03-15', 'Male', 'robert.garcia@email.com', '555-0123', '123 Main St, Anytown, USA', 'A+', 'Maria Garcia', '555-9876'),
('Jennifer', 'Lee', '1988-11-22', 'Female', 'jennifer.lee@email.com', '555-4567', '456 Oak Rd, Somewhere City, USA', 'B-', 'David Lee', '555-6543'),
('Carlos', 'Rodriguez', '1965-07-30', 'Male', 'carlos.rodriguez@email.com', '555-8901', '789 Pine Lane, Another Town, USA', 'O+', 'Sofia Rodriguez', '555-2109'),
('Emma', 'Wilson', '1995-09-10', 'Female', 'emma.wilson@email.com', '555-2345', '321 Maple Drive, Newcity, USA', 'AB-', 'Jack Wilson', '555-7654'),
('Michael', 'Chen', '1980-05-05', 'Male', 'michael.chen@email.com', '555-6789', '654 Elm Street, Techtown, USA', 'A-', 'Lisa Chen', '555-3456');

-- Insert Patient Insurance
INSERT INTO PatientInsurance (patient_id, provider_id, policy_number, coverage_amount, expiry_date) VALUES 
(1, 1, 'HG2023-001', 500000.00, '2024-12-31'),
(2, 2, 'MP2023-002', 750000.00, '2024-11-30'),
(3, 3, 'WC2023-003', 1000000.00, '2024-10-31'),
(4, 1, 'HG2023-004', 600000.00, '2024-09-30'),
(5, 2, 'MP2023-005', 850000.00, '2024-08-31');

-- Insert Appointment Slots
INSERT INTO AppointmentSlots (doctor_id, available_date, start_time, end_time, is_booked) VALUES 
(1, '2024-06-15', '09:00:00', '10:00:00', FALSE),
(1, '2024-06-15', '10:30:00', '11:30:00', FALSE),
(2, '2024-06-16', '14:00:00', '15:00:00', FALSE),
(2, '2024-06-16', '15:30:00', '16:30:00', FALSE),
(3, '2024-06-17', '11:00:00', '12:00:00', FALSE),
(3, '2024-06-17', '13:00:00', '14:00:00', FALSE),
(4, '2024-06-18', '10:00:00', '11:00:00', FALSE),
(4, '2024-06-18', '11:30:00', '12:30:00', FALSE),
(5, '2024-06-19', '15:00:00', '16:00:00', FALSE),
(5, '2024-06-19', '16:30:00', '17:30:00', FALSE);

-- Insert Appointments
INSERT INTO Appointments (patient_id, doctor_id, slot_id, appointment_date, appointment_time, reason, status) VALUES 
(1, 1, 1, '2024-06-15', '09:00:00', 'Annual heart check-up', 'Scheduled'),
(2, 2, 3, '2024-06-16', '14:00:00', 'Headache consultation', 'Scheduled'),
(3, 3, 5, '2024-06-17', '11:00:00', 'Knee pain assessment', 'Scheduled'),
(4, 4, 7, '2024-06-18', '10:00:00', 'Child vaccination', 'Scheduled'),
(5, 5, 9, '2024-06-19', '15:00:00', 'Oncology follow-up', 'Scheduled');

-- Update corresponding appointment slots to booked
UPDATE AppointmentSlots SET is_booked = TRUE 
WHERE slot_id IN (1, 3, 5, 7, 9);

-- Insert Medical Records
INSERT INTO MedicalRecords (patient_id, doctor_id, appointment_id, diagnosis, prescription, treatment_plan, medical_notes) VALUES 
(1, 1, 1, 'Minor heart rhythm irregularity', 'Metoprolol 25mg', 'Monitor heart rate, diet modification', 'Patient advised to reduce salt intake'),
(2, 2, 2, 'Tension headaches', 'Ibuprofen 400mg', 'Stress management techniques', 'Recommended physical therapy'),
(3, 3, 3, 'Early-stage osteoarthritis in knee', 'Naproxen 500mg', 'Physical therapy, weight management', 'Referred to physiotherapist'),
(4, 4, 4, 'Routine child health check', 'MMR Vaccine', 'Regular growth monitoring', 'All vaccinations up to date'),
(5, 5, 5, 'Post-chemotherapy follow-up', 'Ongoing cancer management medication', 'Continue current treatment protocol', 'Stable condition, next scan scheduled');

-- Insert Billing Records
INSERT INTO Billing (patient_id, appointment_id, total_amount, paid_amount, payment_status, payment_method) VALUES 
(1, 1, 250.00, 250.00, 'Fully Paid', 'Credit Card'),
(2, 2, 200.00, 200.00, 'Fully Paid', 'Debit Card'),
(3, 3, 300.00, 150.00, 'Partially Paid', 'Cash'),
(4, 4, 150.00, 0.00, 'Unpaid', NULL),
(5, 5, 500.00, 500.00, 'Fully Paid', 'Insurance');