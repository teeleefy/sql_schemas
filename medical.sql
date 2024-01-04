-- from the terminal run:
-- psql < medical.sql

DROP DATABASE IF EXISTS medical;

CREATE DATABASE medical;

\c medical


CREATE TABLE medical_center (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT
);

CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    birthdate DATE NOT NULL
);

CREATE TABLE diagnosis (
    id SERIAL PRIMARY KEY,
    patient INTEGER REFERENCES patients ON DELETE CASCADE,
    disease INTEGER REFERENCES diseases ON DELETE CASCADE
);



CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    employer INTEGER REFERENCES medical_center ON DELETE SET NULL
);

CREATE TABLE pt_dr (
    id SERIAL PRIMARY KEY,
    patient INTEGER REFERENCES patients ON DELETE CASCADE,
    doctor INTEGER REFERENCES doctors ON DELETE CASCADE
);


INSERT INTO patients
(first_name, last_name, birthdate) VALUES 
('Henry','Davidson','1990-10-12'),
('Sarah','Smith','1983-01-29');

INSERT INTO medical_center
(name, address) VALUES 
('Regional Medical Center','1130 Medical Drive'),
('Vanderbuilt Health Center','2940 Healthway Lane');

INSERT INTO diseases
(name) VALUES 
('Diabetes'),
('Gout'),
('High Blood Pressure');

INSERT INTO doctors
(name, employer) VALUES 
('Dr. Katz', 1),
('Dr. Moore', 2),
('Dr. Patel', 1);

INSERT INTO diagnosis
(patient, disease) VALUES 
(1, 1),
(1, 2),
(2, 3);

INSERT INTO pt_dr
(patient, doctor) VALUES 
(1, 1),
(1, 2),
(2, 3);

