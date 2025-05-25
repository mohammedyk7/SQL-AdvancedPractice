
-- ===================================
-- Part 3: Self-Discovery & Applied Exploration
-- ===================================

-- ====== Subquery Exploration ======

-- 1. What is a subquery?
-- A subquery is a query nested inside another query. It returns data to be used in the main query.

-- 2. Where can subqueries be used?
-- In SELECT, FROM, or WHERE clauses.

-- Task: Find trainees whose emails appear in the Applicants table
SELECT * FROM Trainees
WHERE Email IN (SELECT Email FROM Applicants);

-- Extra Challenge: Delete applicants who are also trainees
DELETE FROM Applicants
WHERE Email IN (SELECT Email FROM Trainees);

-- ====== Transactions & Batch Script ======

-- What is a SQL Transaction?
-- A transaction is a sequence of SQL statements that are treated as a single unit.
-- They follow the ACID properties to ensure data reliability.
-- SQL Keywords: BEGIN TRANSACTION, COMMIT, ROLLBACK

-- Transaction Script: Insert two applicants (second fails with duplicate ID)
BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO Applicants VALUES (104, 'Zahra Al Amri', 'zahra.a@example.com', 'Referral', '2025-05-10');
    INSERT INTO Applicants VALUES (104, 'Error User', 'error@example.com', 'Website', '2025-05-11'); -- Duplicate ID
    COMMIT;
END TRY
BEGIN CATCH
    PRINT 'Error occurred, rolling back...';
    ROLLBACK;
END CATCH;

-- ====== ACID Properties ======

-- Atomicity: All operations in the transaction succeed or fail as a unit.
-- Example: In a bank transfer, if money is deducted but not credited, rollback ensures no half-state.

-- Consistency: Transactions transform the database from one valid state to another.
-- Example: After transferring money, both accounts must still obey rules like "no negative balance".

-- Isolation: Concurrent transactions do not interfere with each other.
-- Example: Two users booking the last movie seat shouldn't overwrite each other’s transaction.

-- Durability: Once committed, changes survive system failures.
-- Example: After submitting an online exam, the server crash won’t erase your answers.

-- ===================================
-- Script created on: 2025-05-25
-- Author: mohammedyk7
-- ===================================
