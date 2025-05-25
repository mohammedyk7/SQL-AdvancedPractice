
-- ===================================

-- Topics: UNION, DELETE vs DROP vs TRUNCATE, Subqueries, Transactions, ACID
-- ===================================

-- ====== PART 1: UNION Practice ======

Tables 
-- Trainees Table 
CREATE TABLE Trainees ( 
    TraineeID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    Program VARCHAR(50), 
    GraduationDate DATE 
); 
 
-- Job Applicants Table 
CREATE TABLE Applicants ( 
    ApplicantID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    Source VARCHAR(20), -- e.g., "Website", "Referral" 
    AppliedDate DATE 
); 
 
-- Insert into Trainees 
INSERT INTO Trainees VALUES 
(1, 'Layla Al Riyami', 'layla.r@example.com', 'Full Stack .NET', '2025-04-30'), 
(2, 'Salim Al Hinai', 'salim.h@example.com', 'Outsystems', '2025-03-15'), 
(3, 'Fatma Al Amri', 'fatma.a@example.com', 'Database Admin', '2025-05-01'); 

-- Insert into Applicants
INSERT INTO Applicants VALUES 
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'),
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'), -- same person as trainees
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28');

 

-- 1. List all unique people (trainees or applicants) using UNION
SELECT FullName, Email FROM Trainees
UNION
SELECT FullName, Email FROM Applicants;

-- 2. Use UNION ALL and observe duplicates
SELECT FullName, Email FROM Trainees
UNION ALL
SELECT FullName, Email FROM Applicants;
-- Observation: Layla Al Riyami appears twice because she exists in both tables.

-- 3. Find people who are in both tables (by Email)
SELECT T.FullName, T.Email
FROM Trainees T
INNER JOIN Applicants A ON T.Email = A.Email;

-- ====== PART 2: DROP, DELETE, TRUNCATE ======

-- 4. DELETE specific rows
DELETE FROM Trainees WHERE Program = 'Outsystems';
-- Observation: Table remains. Only matching row(s) are deleted.

-- 5. TRUNCATE table
TRUNCATE TABLE Applicants;
-- Observation: All data is deleted. Cannot rollback if not in a transaction.

-- 6. DROP table
DROP TABLE Applicants;
-- Observation: Table is completely removed. SELECT from it causes an error.

-- ====== PART 3: Subqueries and Transactions ======

-- 1. Subquery in WHERE clause (find trainees also in applicants)
SELECT * FROM Trainees
WHERE Email IN (SELECT Email FROM Applicants);

-- 2. DELETE using subquery (delete applicants who are also trainees)
DELETE FROM Applicants
WHERE Email IN (SELECT Email FROM Trainees);

-- 3. Transaction block with intentional failure
BEGIN TRANSACTION;

INSERT INTO Applicants VALUES (104, 'Zahra Al Amri', 'zahra.a@example.com', 'Referral', '2025-05-10');
INSERT INTO Applicants VALUES (104, 'Error User', 'error@example.com', 'Website', '2025-05-11'); -- Duplicate ID

-- Uncomment based on test result:
-- COMMIT;
-- ROLLBACK;

-- 4. ACID Properties Summary (write your answer here as comments)
-- Atomicity: All steps succeed or fail together. Like a bank transfer: debit + credit.
-- Consistency: DB remains valid before and after transaction. No broken rules.
-- Isolation: Transactions don’t interfere. Like two ATMs working on same account safely.
-- Durability: Once committed, changes survive crash. Like saving a doc and power goes out.

-- END OF SCRIPT
-- Created on 2025-05-25
