 Hospital Appointment Management System

 Overview

This project is a PostgreSQL database designed for managing hospital appointments. It demonstrates database normalization, relationships, indexing, views, and materialized views to improve query performance.

 Database Tables

 PATIENT
Stores patient information.

- PatientID (Primary Key)
- FirstName
- LastName
- Gender
- DateOfBirth
- Phone
- Address

 DOCTOR
Stores doctor information.

- DoctorID (Primary Key)
- FirstName
- LastName
- Specialization
- Phone
- DepartmentID (Foreign Key)

 DEPARTMENT
Stores hospital departments.

- DepartmentID (Primary Key)
- DepartmentName

 APPOINTMENT
Stores appointment information.

- AppointmentID (Primary Key)
- AppointmentDate
- AppointmentTime
- Status
- PatientID (Foreign Key)
- DoctorID (Foreign Key)

---

 Relationships

- One Department has many Doctors.
- One Doctor has many Appointments.
- One Patient has many Appointments.

---

 Features

- Database normalization
- Primary and Foreign Keys
- SQL Joins
- Views
- Materialized Views
- Indexing
- Query optimization

---

 SQL Objects

 View

A SQL View combines appointment information with patient, doctor, and department details.

Example:

- Appointment Date
- Appointment Time
- Status
- Patient Name
- Doctor Name
- Department Name

---

 Materialized View

A Materialized View named:

AppointmentDetails_MV

stores the joined data physically to improve the performance of reporting queries.

It includes:

- Appointment Date
- Appointment Time
- Status
- Patient Information
- Doctor Information
- Department Name

---

 Index

An index was created on the Patient FirstName column to speed up search operations.

```sql

CREATE INDEX idx_patient_firstname
ON AppointmentDetails_MV(PatientFirstName);

SELECT *
FROM AppointmentDetails_MV
WHERE PatientFirstName = 'Ahmed';
