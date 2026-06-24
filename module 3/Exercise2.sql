--Scenario 1:Process monthly interest
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER
);

INSERT INTO Accounts VALUES (1,101,'SAVINGS',10000);
INSERT INTO Accounts VALUES (2,102,'SAVINGS',20000);
COMMIT;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'SAVINGS';

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Monthly interest processed successfully');
END;
/

EXEC ProcessMonthlyInterest;

SELECT * FROM Accounts;

--Scenario 2:Update Employee Bonus
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(50),
    Department VARCHAR2(30),
    Salary NUMBER
);

INSERT INTO Employees VALUES (1,'Ravi','IT',50000);
INSERT INTO Employees VALUES (2,'Kiran','IT',60000);
INSERT INTO Employees VALUES (3,'Anu','HR',45000);
COMMIT;

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus
(
    p_department IN VARCHAR2,
    p_bonus_percent IN NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary = Salary +
                 (Salary * p_bonus_percent / 100)
    WHERE Department = p_department;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Bonus Updated Successfully');
END;
/

EXEC UpdateEmployeeBonus('IT',10);

SELECT * FROM Employees;

--Scenario 3: Transfer Funds
INSERT INTO Accounts VALUES (3,103,'SAVINGS',15000);
COMMIT;

CREATE OR REPLACE PROCEDURE TransferFunds
(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN

    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = p_from_account;

    IF v_balance >= p_amount THEN

        UPDATE Accounts
        SET Balance = Balance - p_amount
        WHERE AccountID = p_from_account;

        UPDATE Accounts
        SET Balance = Balance + p_amount
        WHERE AccountID = p_to_account;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Transfer Successful');

    ELSE

        DBMS_OUTPUT.PUT_LINE('Insufficient Balance');

    END IF;

END;
/

EXEC TransferFunds(1,2,1000);

SELECT * FROM Accounts;

EXEC ProcedureName;