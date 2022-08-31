 -- Alumno: Nicola Galante Giovannone / Parrilla 34945
drop schema if exists prestapp;
create schema prestapp;
create table clients
(
client_id	int not null auto_increment,
client_name	varchar(20) not null,
document_number varchar(11) not null,
address		varchar(50) not null,
email		varchar(50) not null,
registration_date date not null,
primary key (client_id));

create table leads
(
lead_id	int not null auto_increment,
lead_name	varchar(20) not null,
lead_status varchar(20) not null,
lead_source		varchar(50),
payroll		float not null,
employer_id int not null,
lead_date date not null,
primary key (lead_id),
foreign key (employer_id) references employer(employer_id));

create table status_leads
(
status_id	int not null auto_increment primary key,
status_name	varchar(20) not null,
status_description varchar(20) not null,
is_active		boolean,
status_date date not null
);

create table employer
(
employer_id	int not null auto_increment primary key,
employer_name	varchar(20) not null,
employer_type varchar(20) not null,
payment_date int
);

create table loan
(
loan_id	int not null auto_increment primary key,
installments int not null,
installment_amount float not null,
total_amount float not null,
due_amount float not null,
loan_status int not null,
transfered boolean,
employer_id	int not null,
loan_date date not null,
foreign key (employer_id) references employer(employer_id),
foreign key (loan_status) references loan_status(status_id)
);

create table loan_status
(
status_id	int not null auto_increment primary key,
status_name varchar(50) not null,
status_description varchar(255),
status_type varchar(50)
);

create table loan_status_history
(
status_history_id	int not null auto_increment primary key,
loan_id	int,
operator varchar(50),
status_id int,
history_date date,
foreign key (loan_id) references loan(loan_id),
foreign key (operator) references operator(email),
foreign key (status_id) references loan_status(status_id)
);

create table operator
(
email varchar(50) not null primary key,
operator_name varchar(50),
surname varchar(50),
password varchar(255)
);

