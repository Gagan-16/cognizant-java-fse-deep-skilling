CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    DOB DATE,
    Balance NUMBER,
    IsVIP VARCHAR2(5)
);

SELECT table_name
FROM user_tables;

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    InterestRate NUMBER,
    DueDate DATE,
    CONSTRAINT fk_customer
        FOREIGN KEY (CustomerID)
        REFERENCES CUSTOMERS(CustomerID)
);
SELECT * FROM CUSTOMERS;
SELECT * FROM LOANS;
INSERT INTO CUSTOMERS VALUES
(101,'Ramesh',TO_DATE('10-05-1955','DD-MM-YYYY'),15000,'FALSE');

INSERT INTO CUSTOMERS VALUES
(102,'Suresh',TO_DATE('15-08-1985','DD-MM-YYYY'),8000,'FALSE');

INSERT INTO LOANS VALUES
(201,101,10,SYSDATE+15);

INSERT INTO LOANS VALUES
(202,102,12,SYSDATE+20);

COMMIT;
SELECT * FROM CUSTOMERS;
SELECT * FROM LOANS;

--Scenario 1: Apply a discount on interest rate for customers above 60 years of age.
DECLARE
    CURSOR cust_cursor IS
        SELECT CustomerID, DOB
        FROM Customers;

    v_age NUMBER;
BEGIN
    FOR cust_rec IN cust_cursor LOOP
        v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, cust_rec.DOB) / 12);

        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = cust_rec.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'Discount applied for Customer ID: ' ||
                cust_rec.CustomerID
            );
        END IF;
    END LOOP;

    COMMIT;
END;
/
--Scenario 2: Grant VIP status to customers with a balance greater than $10,000.
DECLARE
    CURSOR cust_cursor IS
        SELECT CustomerID, Balance
        FROM Customers;
BEGIN
    FOR cust_rec IN cust_cursor LOOP
        IF cust_rec.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = cust_rec.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'VIP Status Granted to Customer ID: ' ||
                cust_rec.CustomerID
            );
        END IF;
    END LOOP;

    COMMIT;
END;
/

--Scenario 3: Send reminders for loans due in the next 30 days.
DECLARE
    CURSOR loan_cursor IS
        SELECT CustomerID, LoanID, DueDate
        FROM Loans
        WHERE DueDate BETWEEN SYSDATE AND SYSDATE + 30;
BEGIN
    FOR loan_rec IN loan_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder: Loan ID ' ||
            loan_rec.LoanID ||
            ' for Customer ID ' ||
            loan_rec.CustomerID ||
            ' is due on ' ||
            TO_CHAR(loan_rec.DueDate, 'DD-MON-YYYY')
        );
    END LOOP;
END;
/