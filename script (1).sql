drop database IF EXISTS DigitalGrocery;

-- Create the DigitalGrocery database
CREATE DATABASE DigitalGrocery;

-- Use the DigitalGrocery database
USE DigitalGrocery;

-- Create tables in the DigitalGrocery database
Create table money(
id int auto_increment primary key,
unit_price DECIMAL(10,2) NOT NULL,
unit_fund DECIMAL(10,2) NOT NULL
);
create table roles(
id int auto_increment primary key,
name varchar(20) not null
);
-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username NVARCHAR(20) NOT NULL,
    password NVARCHAR(200) NOT NULL,
    email NVARCHAR(50) NOT NULL,
    phone NCHAR(10),
    first_name NVARCHAR(20) NOT NULL,
    last_name NVARCHAR(20),
    role_id INT NOT NULL,
    is_deleted BOOLEAN NOT NULL,
    is_verified BOOLEAN NOT NULL,
    deleted_date DATE,
    deleted_by INT,
    created_date DATE NOT NULL,
    created_by INT,
    last_updated DATE,
    updated_by INT,
    foreign key (role_id) references roles(id),
	foreign key (deleted_by) references users(Id),
	foreign key (updated_by) references users(Id),
	foreign key (created_by) references users(Id)
);
-- Publishers Table
CREATE TABLE publishers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name NVARCHAR(30) NOT NULL,
    image NVARCHAR(200) NOT NULL,
    is_deleted BOOLEAN NOT NULL,
    deleted_date DATE,
    deleted_by INT,
    created_date DATE NOT NULL,
    created_by INT,
    last_updated DATE,
    updated_by INT,
	foreign key (deleted_by) references users(Id),
    foreign key (updated_by) references users(Id),
    foreign key (created_by) references users(Id)
);

CREATE TABLE card_types(
	id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_id INT NOT NULL,
    money_id int not null,
	in_stock INT NOT NULL,
	sold_quantity INT NOT NULL,
    is_deleted BOOLEAN NOT NULL,
    deleted_date DATE,
    deleted_by INT,
    created_date DATE NOT NULL,
    created_by INT NOT NULL,
    foreign key (money_id) references money(id),
    foreign key (publisher_id) references publishers(Id),
    foreign key (deleted_by) references users(Id),
    foreign key (created_by) references users(Id)
);
-- Cards Table
CREATE TABLE cards (
	id INT AUTO_INCREMENT PRIMARY KEY,
    card_type_id INT NOT NULL,
    seri_number NVARCHAR(30) NOT NULL,
    card_number NVARCHAR(30) NOT NULL,
	expiry_date DATE NOT NULL,
    is_deleted BOOLEAN NOT NULL,
    deleted_date DATE,
    deleted_by INT,
    created_date DATE NOT NULL,
    created_by INT NOT NULL,
    last_updated DATE,
    updated_by INT,
	foreign key (card_type_id) references card_types(Id),
    foreign key (deleted_by) references users(Id),
    foreign key (updated_by) references users(Id),
	foreign key (created_by) references users(Id)
);

-- CartItems Table
CREATE TABLE cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    card_type_id INT NOT NULL,
    quantity INT NOT NULL,
    total DECIMAL(10,2),
    foreign key (user_id) references users(id),
    foreign key (card_type_id) references card_types(Id)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_money DECIMAL(10,2) NOT NULL,
    status NVARCHAR(20) DEFAULT 'pending',
    order_date DATE NOT NULL,
	card_last nchar(4) NULL,
    authorization_code VARCHAR(20),
    transaction_content VARCHAR(20),
    foreign key (user_id) references users(Id)
);
-- OrderDetails Table
CREATE TABLE order_details (
	id INT auto_increment primary key,
    order_id INT NOT NULL,
    card_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (card_id) REFERENCES cards(id)
);

insert into money (id,unit_price,unit_fund)
values  (1,9000,10000),
		(2,17000,20000),
        (3,40000,50000),
        (4,80000,100000),
        (5,160000,200000),
        (6,450000,500000)
;
insert into roles(id,name)
values (1,'admin'),
	   (2,'customer');
-- Bảng Users
INSERT INTO users (id, username, password, email, phone, first_name, last_name, role_id, is_deleted,is_verified, deleted_date, deleted_by, created_date, created_by, last_updated, updated_by) 
VALUES (1, 'dung2002ss', '25d55ad283aa400af464c76d713c07ad', 'dung2002ss@gmail.com', NULL, 'Dung', 'Le', 2, 0, 1,NULL, NULL, CAST('2024-05-19' AS DATE), 1, NULL, NULL),
       (2, 'swp391_g1', '25d55ad283aa400af464c76d713c07ad', 'nghiemngoc2912@gmail.com', NULL, 'Ngoc', NULL, 1, 0,1, NULL, NULL, CAST('2024-05-19' AS DATE), 1, NULL, NULL);


-- Bảng Publishers
INSERT INTO publishers (id, name,image ,is_deleted, deleted_date, deleted_by, created_date, created_by, last_updated, updated_by) 
VALUES (1, 'Viettel','viettel.jpg', 0, NULL, NULL, CAST('2024-05-19' AS DATE), 1, NULL, NULL),
       (2, 'MobileFone','mobilephone.jpg', 0, NULL, NULL, CAST('2024-05-19' AS DATE), 1, NULL, NULL),
       (3, 'VinaPhone','vinaphone.jpg', 0, NULL, NULL, CAST('2023-05-19' AS DATE), 1, NULL, NULL);
INSERT INTO card_types(publisher_id,money_id, in_stock, sold_quantity, is_deleted, deleted_date, deleted_by, created_date, created_by)
VALUES
(1,1, 2, 1,  FALSE, NULL, NULL, '2024-01-01', 2),
(1,5,2 , 0, FALSE, NULL, NULL, '2024-01-01', 2),
(1,3, 2, 0, FALSE, NULL, NULL,'2024-01-01', 2),
(2, 4, 2, 0, FALSE, NULL, NULL,'2024-01-01', 2),
(2,5, 2, 0, FALSE, NULL, NULL,'2024-01-01', 2),
(2,6, 2, 0, FALSE, NULL, NULL,'2024-01-01', 2),
(2,1, 2, 0, FALSE, NULL, NULL,'2024-01-01', 2),
(3,2, 2, 0, FALSE, NULL, NULL,'2024-01-01', 2),
(3,3, 2, 0, FALSE, NULL, NULL,'2024-01-01', 2),
(3, 4, 2, 0, FALSE, NULL, NULL,'2024-01-01', 2);

INSERT INTO cards (card_type_id, seri_number, card_number, is_deleted, deleted_date, deleted_by, created_date, created_by, last_updated, updated_by,expiry_date)
VALUES 
(1, 'SER12345', 'CARD12545', TRUE, '2024-05-01', NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(2, 'SER12346', 'CARD12245', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(3, 'SER12347', 'CARD11345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(4, 'SER02345', 'CARD14345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(5, 'SER12335', 'CARD12345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(6, 'SER12005', 'CARD17345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(7, 'SER10015', 'CARD02345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(8, 'SER12305', 'CARD82345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(9, 'SER00325', 'CARD62345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(10, 'SER12145', 'CARD12545', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(1, 'SER10395', 'CARD12375', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(2, 'SER01375', 'CARD12385', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(3, 'SER16345', 'CARD12325', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(4, 'SER14345', 'CARD12305', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(5, 'SER11345', 'CARD32345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(6, 'SER10345', 'CARD52345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(7, 'SER21345', 'CARD23345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(8, 'SER32345', 'CARD34345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(9, 'SER52345', 'CARD56345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(10, 'SER72345', 'CARD60345', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31'),
(1, 'SER10045', 'CARD00545', FALSE, NULL, NULL,'2024-01-01', 1, NULL,NULL,'2025-12-31');
INSERT INTO cart_items (user_id, card_type_id, quantity, total)
VALUES 
(1, 1, 2, 20000),
(2, 2, 1, 200000);
INSERT INTO orders (user_id, total_money, status, order_date, card_last, authorization_code,transaction_content)
VALUES 
(1, 10000, 'complete', '2024-05-01', '1234', 'AUTH123','AF183S1T'),
(2, 200000, 'pending', '2024-05-01', '5678', 'AUTH456','XY12421Q');
INSERT INTO order_details (order_id, card_id)
VALUES 
(1, 1);


