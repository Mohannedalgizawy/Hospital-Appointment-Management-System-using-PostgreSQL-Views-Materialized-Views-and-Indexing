create table DEPARTMENT
(
   DepartmentID CHAR(4) primary key,
   DepartmentName varchar(100)
)

create table DOCTOR
(
   DoctorID CHAR(4) primary key,
   FirstName varchar(100),
   LastName varchar(100),
   Specialization varchar(100),
   Phone varchar(100),
   DepartmentID CHAR(4),
   CONSTRAINT fk_DOCTOR_DEPARTMENT FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
)

create table PATIENT
(
   PatientID CHAR(4) primary key,
   FirstName varchar(100),
   LastName varchar(100),
   Gender varchar(100),
   DateOfBirth date,
   Phone varchar(100),
   Address varchar(100)
)

create table APPOINTMENT
(
   AppointmentID char(4) primary key,
   AppointmentDate date,
   AppointmentTime varchar(100),
   Status varchar(100),
   PatientID CHAR(4),
   DoctorID CHAR(4),
   CONSTRAINT fk_DOCTOR_APPOINTMENT FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID),
   CONSTRAINT fk_DOCTOR_PATIENT FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID)
)

INSERT INTO Department (DepartmentID, DepartmentName)
VALUES
('D001', 'Cardiology'),
('D002', 'Neurology'),
('D003', 'Orthopedics'),
('D004', 'Pediatrics'),
('D005', 'Dermatology'),
('D006', 'Ophthalmology'),
('D007', 'Emergency Medicine'),
('D008', 'General Surgery'),
('D009', 'Oncology'),
('D010', 'Gynecology');

INSERT INTO Doctor 
(DoctorID, FirstName, LastName, Specialization, Phone, DepartmentID)
VALUES
('D001', 'Ahmed', 'Hassan', 'Interventional Cardiologist', '01012345678', 'D001'),

('D002', 'Sara', 'Mohamed', 'Neurologist (Brain & Nervous System)', '01123456789', 'D002'),

('D003', 'Omar', 'Ali', 'Orthopedic Surgeon', '01234567890', 'D003'),

('D004', 'Mona', 'Ibrahim', 'Pediatrician (Child Specialist)', '01098765432', 'D004'),

('D005', 'Youssef', 'Khaled', 'Dermatologist (Skin Diseases)', '01187654321', 'D005'),

('D006', 'Nada', 'Adel', 'Ophthalmologist (Eye Specialist)', '01276543210', 'D006'),

('D007', 'Karim', 'Samir', 'Emergency Medicine Specialist', '01065432198', 'D007'),

('D008', 'Hany', 'Mostafa', 'General Surgeon', '01154321987', 'D008'),

('D009', 'Laila', 'Ahmed', 'Medical Oncologist', '01243219876', 'D009'),

('D010', 'Reem', 'Tarek', 'Gynecologist (Women Health)', '01032198765', 'D010');

INSERT INTO Patient
(PatientID, FirstName, LastName, Gender, DateOfBirth, Phone, Address)
VALUES
('P001', 'Mahmoud', 'Ali', 'Male', '1985-03-12', '01011112222', 'Cairo'),

('P002', 'Fatma', 'Hassan', 'Female', '1992-07-25', '01122223333', 'Giza'),

('P003', 'Mostafa', 'Ahmed', 'Male', '1978-11-08', '01233334444', 'Alexandria'),

('P004', 'Salma', 'Omar', 'Female', '2015-05-20', '01044445555', 'Cairo'),

('P005', 'Yara', 'Khaled', 'Female', '1998-09-15', '01155556666', 'Mansoura'),

('P006', 'Ahmed', 'Samir', 'Male', '1969-01-30', '01266667777', 'Tanta'),

('P007', 'Nour', 'Adel', 'Female', '1988-12-10', '01077778888', 'Cairo'),

('P008', 'Hassan', 'Mostafa', 'Male', '2000-06-18', '01188889999', 'Giza');

INSERT INTO Appointment
(AppointmentID, AppointmentDate, AppointmentTime, Status, PatientID, DoctorID)
VALUES
('A001', '2026-07-29', '09:00:00', 'Completed', 'P001', 'D001'),

('A002', '2026-07-29', '10:30:00', 'Scheduled', 'P002', 'D005'),

('A003', '2026-07-30', '11:00:00', 'Completed', 'P003', 'D003'),

('A004', '2026-07-30', '14:00:00', 'Cancelled', 'P004', 'D004'),

('A005', '2026-07-31', '09:30:00', 'Scheduled', 'P005', 'D010'),

('A006', '2026-08-01', '13:00:00', 'Completed', 'P006', 'D002'),

('A007', '2026-08-01', '15:30:00', 'Scheduled', 'P007', 'D006'),

('A008', '2026-08-02', '08:00:00', 'Emergency', 'P008', 'D007');

CREATE MATERIALIZED VIEW AppointmentDetails_MV
AS
SELECT
    A.AppointmentDate,
    A.AppointmentTime,
    A.Status,

    P.FirstName AS PatientFirstName,
    P.LastName AS PatientLastName,
    P.Gender,
    P.DateOfBirth,
    P.Phone AS PatientPhone,
    P.Address,

    D.FirstName AS DoctorFirstName,
    D.LastName AS DoctorLastName,
    D.Specialization,
    D.Phone AS DoctorPhone,

    DE.DepartmentName

FROM APPOINTMENT A
JOIN PATIENT P
    ON A.PatientID = P.PatientID

JOIN DOCTOR D
    ON A.DoctorID = D.DoctorID

JOIN DEPARTMENT DE
    ON D.DepartmentID = DE.DepartmentID;

SELECT *
FROM AppointmentDetails_MV;

CREATE INDEX idx_patient_firstname
ON AppointmentDetails_MV(PatientFirstName);

SELECT *
FROM AppointmentDetails_MV
WHERE PatientFirstName = 'Ahmed';