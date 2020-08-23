CREATE TABLE customer (
    Customer_ID VARCHAR2(8) NOT NULL,
    customer_name VARCHAR2(80) NOT NULL,
    gender VARCHAR2(10) NOT NULL,
	DOB DATE NOT NULL,
	age INT NOT NULL CHECK(age>=18),
    address VARCHAR2(100) NOT NULL,
    email_ID VARCHAR(80) NOT NULL,
    SSN VARCHAR2(30) UNIQUE NOT NULL,
    PRIMARY KEY(Customer_ID)
);

CREATE TABLE branch(
    IFSC_code VARCHAR2(11) NOT NULL,
    branch_address VARCHAR2(100) NOT NULL,
    phone_No INT NOT NULL,
    region VARCHAR2(50) NOT NULL,
    zip_code INT NOT NULL,
    PRIMARY KEY(IFSC_code)
);

CREATE TABLE departments(
 dept_id VARCHAR2(20) NOT NULL, 
 dept_name VARCHAR(80) NOT NULL,
 PRIMARY KEY(dept_id)
);

CREATE TABLE atm(
 atm_ID VARCHAR2(20) NOT NULL, 
 atm_address VARCHAR2(100) NOT NULL,
 IFSC_code VARCHAR2(11),
 PRIMARY KEY (atm_ID),
 FOREIGN KEY (IFSC_code) REFERENCES branch(IFSC_code) ON DELETE CASCADE
);

CREATE TABLE lockers(
 locker_ID INT NOT NULL,
 customer_id varchar2(8) NOT NULL,
 IFSC_code VARCHAR2(11) NOT NULL,
 PRIMARY KEY(locker_id),
 FOREIGN KEY(IFSC_code) REFERENCES branch(IFSC_code) ON DELETE CASCADE,
 FOREIGN KEY(customer_ID) REFERENCES customer(customer_ID) ON DELETE CASCADE
 );
 
 CREATE TABLE accounts(
	customer_ID VARCHAR2(8) NOT NULL,
    acc_no INT NOT NULL,
	acc_type VARCHAR2(15) NOT NULL,
    open_date DATE NOT NULL,
    current_balance FLOAT NOT NULL,
	IFSC_code VARCHAR2(11) NOT NULL,
    PRIMARY KEY(acc_no),
    FOREIGN KEY(IFSC_code) REFERENCES branch(IFSC_code) ON DELETE CASCADE,
    FOREIGN KEY(customer_ID) REFERENCES customer(customer_ID) ON DELETE CASCADE
);

CREATE TABLE employee (
    employee_ID VARCHAR2(6) NOT NULL,
    IFSC_code VARCHAR2(11) NOT NULL,
    dept_ID VARCHAR2(10) NOT NULL,
    join_date DATE NOT NULL,
    employee_position VARCHAR2(50) NOT NULL,
    PRIMARY KEY(employee_ID),
    FOREIGN KEY(IFSC_code) REFERENCES branch(IFSC_code) ON DELETE CASCADE,
    FOREIGN KEY(dept_ID) REFERENCES departments(dept_id) ON DELETE CASCADE    
);

CREATE TABLE card_info(
customer_ID VARCHAR2(8) NOT NULL,
card_number INT NOT NULL,
card_type VARCHAR2(20) NOT NULL,
acc_no INT NOT NULL,
IFSC_code VARCHAR2(11) NOT NULL,
issue_date DATE NOT NULL,
PRIMARY KEY(card_number),
FOREIGN KEY(IFSC_code) REFERENCES branch(IFSC_code) ON DELETE CASCADE,
FOREIGN KEY(customer_ID) REFERENCES customer(customer_ID) ON DELETE CASCADE,
FOREIGN KEY(acc_no) REFERENCES accounts(acc_no) ON DELETE CASCADE
);

CREATE TABLE loan (
customer_ID VARCHAR2(8) NOT NULL,
loan_id VARCHAR(10),
IFSC_code VARCHAR(11) NOT NULL,
date_initiated DATE NOT NULL,
loan_duration INT NOT NULL,
interest FLOAT NOT NULL,
acc_no INT NOT NULL,
PRIMARY KEY(loan_id),
FOREIGN KEY(IFSC_code) REFERENCES branch(IFSC_code) ON DELETE CASCADE,
FOREIGN KEY(customer_ID) REFERENCES customer(customer_ID) ON DELETE CASCADE,
FOREIGN KEY(acc_no) REFERENCES accounts(acc_no) ON DELETE CASCADE
);

CREATE TABLE transactions(		
    customer_ID VARCHAR2(8) NOT NULL,					
    acc_no INT NOT NULL,
	transaction_ID VARCHAR2(8) NOT NULL,
    amount FLOAT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR2(15) NOT NULL,
    PRIMARY KEY(transaction_ID),
    FOREIGN KEY(customer_ID) REFERENCES customer(customer_ID),
	FOREIGN KEY(acc_no) REFERENCES accounts(acc_no)
);
