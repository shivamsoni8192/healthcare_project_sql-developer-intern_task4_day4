
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(50)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT,
    diagnosis VARCHAR(100),
    treatment_description TEXT,
    cost DECIMAL(10,2),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    treatment_id INT,
    payment_mode VARCHAR(50),
    is_paid BOOLEAN,
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id)
);

INSERT INTO Patients (name, age, gender) VALUES
('Ravi Kumar', 45, 'Male'),
('Monika Devi', 60, 'Female'),
('Anil Yadav', 35, 'Male'),
('Kavita Verma', 50, 'Female'),
('Manoj Singh', 45, 'Male');

INSERT INTO Doctors (name, specialization) VALUES
('Dr. Rao', 'Cardiologist'),
('Dr. Sharma', 'Pulmonologist'),
('Dr. Mehta', 'General Physician');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date) VALUES
(1, 1, '2025-08-01'),
(2, 1, '2025-08-02'),
(3, 2, '2025-08-03'),
(4, 3, '2025-08-04'),
(5, 1, '2025-08-05');

INSERT INTO Treatments (appointment_id, diagnosis, treatment_description, cost) VALUES
(1, 'Heart Disease', 'Angioplasty', 25000.00),
(2, 'Hypertension', 'Medication and Monitoring', 12000.00),
(3, 'Asthma', 'Inhaler and Therapy', 8000.00),
(4, 'Fever', 'Blood Test and Medication', 4000.00),
(5, 'Chest Pain', 'ECG and Tests', 10000.00);

INSERT INTO Bills (treatment_id, payment_mode, is_paid) VALUES
(1, 'Credit Card', TRUE),
(2, 'Cash', TRUE),
(3, 'UPI', FALSE),
(4, 'Debit Card', TRUE),
(5, 'Cash', TRUE);

SELECT SUM(cost) AS total_revenue FROM Treatments;

SELECT AVG(cost) AS avg_cost FROM Treatments;

SELECT MAX(cost) AS highest_cost FROM Treatments;

SELECT COUNT(*) AS paid_bills FROM Bills WHERE is_paid = TRUE;

SELECT d.name AS doctor_name, COUNT(*) AS total_patients
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name;

SELECT diagnosis, AVG(cost) AS avg_cost
FROM Treatments
GROUP BY diagnosis;

SELECT d.name AS doctor_name, SUM(t.cost) AS total_revenue
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
JOIN Treatments t ON a.appointment_id = t.appointment_id
GROUP BY d.name;

SELECT d.name AS doctor_name, SUM(t.cost) AS total_revenue
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
JOIN Treatments t ON a.appointment_id = t.appointment_id
GROUP BY d.name
HAVING total_revenue > 20000;