BEGIN
  FOR c IN ( SELECT table_name FROM user_tables)
  LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS' ;
  END LOOP;
END;
 
/

BEGIN
  FOR c IN ( SELECT sequence_name FROM user_sequences WHERE sequence_name NOT LIKE '%$%')
  LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || c.sequence_name;
  END LOOP;
END;

/

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-04-05 18:19:55.448

-- tables
-- Table: Action
CREATE TABLE Action (
    IdAction integer  NOT NULL,
    IdBuyingTransaction integer  NOT NULL,
    IdItem integer  NOT NULL,
    Quantity integer  NOT NULL,
    CONSTRAINT Action_pk PRIMARY KEY (IdAction)
) ;

-- Table: BuyingTransaction
CREATE TABLE BuyingTransaction (
    IdBuyingTransaction integer  NOT NULL,
    IdPaymentType integer  NOT NULL,
    IdCustomer integer  NOT NULL,
    IdEmp integer  NOT NULL,
    DateTrans date  NOT NULL,
    Description varchar2(100)  NULL,
    CONSTRAINT BuyingTransaction_pk PRIMARY KEY (IdBuyingTransaction)
) ;

-- Table: Customer
CREATE TABLE Customer (
    IdCustomer integer  NOT NULL,
    IdStatus integer  NOT NULL,
    FirstName varchar2(50)  NOT NULL,
    SecondName varchar2(50)  NOT NULL,
    Email varchar2(50)  NOT NULL,
    Address varchar2(100)  NOT NULL,
    DoB date  NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY (IdCustomer)
) ;

CREATE TABLE CustomerHistory (
    IdHistory integer  NOT NULL,
    IdCustomer integer  NOT NULL,
    dateHis date  NOT NULL,
    Changes varchar2(100)  NULL,
    CONSTRAINT CustomerHistory_pk PRIMARY KEY (IdHistory)
) ;

-- Table: Emp
CREATE TABLE Emp (
    IdEmp integer  NOT NULL,
    FirstName varchar2(50)  NOT NULL,
    SecondName varchar2(50)  NOT NULL,
    PhoneNumber varchar2(30)  NOT NULL,
    Address varchar2(100)  NOT NULL,
    DoB date  NOT NULL,
    CONSTRAINT Emp_pk PRIMARY KEY (IdEmp)
) ;

-- Table: Item
CREATE TABLE Item (
    IdItem integer  NOT NULL,
    IdManCode integer  NOT NULL,
    IdItemType integer  NOT NULL,
    IdStorageLocation integer  NOT NULL,
    ItemName varchar2(50)  NOT NULL,
    Price integer  NOT NULL,
    Description varchar2(100)  NULL,
    CONSTRAINT Item_pk PRIMARY KEY (IdItem)
) ;

-- Table: ItemType
CREATE TABLE ItemType (
    IdItemType integer  NOT NULL,
    ItemTypeName varchar2(100)  NOT NULL,
    CONSTRAINT ItemType_pk PRIMARY KEY (IdItemType)
) ;

-- Table: ManufactureCode
CREATE TABLE ManufactureCode (
    IdManCode integer  NOT NULL,
    ManufactureName varchar2(100)  NOT NULL,
    CONSTRAINT ManufactureCode_pk PRIMARY KEY (IdManCode)
) ;

-- Table: PaymentType
CREATE TABLE PaymentType (
    IdPaymentType integer  NOT NULL,
    PaymentName varchar2(50)  NOT NULL,
    Description varchar2(100)  NULL,
    CONSTRAINT PaymentType_pk PRIMARY KEY (IdPaymentType)
) ;

-- Table: Status
CREATE TABLE Status (
    IdStatus integer  NOT NULL,
    StatusName varchar2(100)  NOT NULL,
    CONSTRAINT Status_pk PRIMARY KEY (IdStatus)
) ;

-- Table: StorageLocation
CREATE TABLE StorageLocation (
    IdStorageLocation integer  NOT NULL,
    IdEmp integer  NOT NULL,
    Address varchar2(100)  NOT NULL,
    PhoneNumber varchar2(30)  NOT NULL,
    CONSTRAINT StorageLocation_pk PRIMARY KEY (IdStorageLocation)
) ;

-- foreign keys
-- Reference: Action_BuyingTransaction (table: Action)
ALTER TABLE Action ADD CONSTRAINT Action_BuyingTransaction
    FOREIGN KEY (IdBuyingTransaction)
    REFERENCES BuyingTransaction (IdBuyingTransaction);

-- Reference: Action_Item (table: Action)
ALTER TABLE Action ADD CONSTRAINT Action_Item
    FOREIGN KEY (IdItem)
    REFERENCES Item (IdItem);

-- Reference: BuyingTransaction_Customer (table: BuyingTransaction)
ALTER TABLE BuyingTransaction ADD CONSTRAINT BuyingTransaction_Customer
    FOREIGN KEY (IdCustomer)
    REFERENCES Customer (IdCustomer);

-- Reference: BuyingTransaction_Emp (table: BuyingTransaction)
ALTER TABLE BuyingTransaction ADD CONSTRAINT BuyingTransaction_Emp
    FOREIGN KEY (IdEmp)
    REFERENCES Emp (IdEmp);

-- Reference: BuyingTransaction_PaymentType (table: BuyingTransaction)
ALTER TABLE BuyingTransaction ADD CONSTRAINT BuyingTransaction_PaymentType
    FOREIGN KEY (IdPaymentType)
    REFERENCES PaymentType (IdPaymentType);

-- Reference: Customer_Status (table: Customer)
ALTER TABLE Customer ADD CONSTRAINT Customer_Status
    FOREIGN KEY (IdStatus)
    REFERENCES Status (IdStatus);
    
-- Reference:  CustomerHistory_Customer
ALTER TABLE CustomerHistory ADD CONSTRAINT CustomerHistory_Customer
    FOREIGN KEY (IdCustomer)
    REFERENCES Customer (IdCustomer);
    
-- Reference: Item_ItemType (table: Item)
ALTER TABLE Item ADD CONSTRAINT Item_ItemType
    FOREIGN KEY (IdItemType)
    REFERENCES ItemType (IdItemType);

-- Reference: Item_ManufactureCode (table: Item)
ALTER TABLE Item ADD CONSTRAINT Item_ManufactureCode
    FOREIGN KEY (IdManCode)
    REFERENCES ManufactureCode (IdManCode);

-- Reference: Item_StorageLocation (table: Item)
ALTER TABLE Item ADD CONSTRAINT Item_StorageLocation
    FOREIGN KEY (IdStorageLocation)
    REFERENCES StorageLocation (IdStorageLocation);

-- Reference: StorageLocation_Emp (table: StorageLocation)
ALTER TABLE StorageLocation ADD CONSTRAINT StorageLocation_Emp
    FOREIGN KEY (IdEmp)
    REFERENCES Emp (IdEmp);

-- End of file.



-- STATUS ENTITY
CREATE SEQUENCE status_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO Status(IdStatus, StatusName)
VALUES (status_seq.nextval, 'New Customer');
INSERT INTO Status(IdStatus, StatusName)
VALUES (status_seq.nextval, '5% discount');
INSERT INTO Status(IdStatus, StatusName)
VALUES (status_seq.nextval, '10% discount');
INSERT INTO Status(IdStatus, StatusName)
VALUES (status_seq.nextval, '30% discount');
INSERT INTO Status(IdStatus, StatusName)
VALUES (status_seq.nextval, 'BLACKLIST');


-- MANUFACTURECODE ENTITY
CREATE SEQUENCE mancode_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO ManufactureCode(IdManCode, ManufactureName)
VALUES (mancode_seq.nextval, 'MaxSem');
INSERT INTO ManufactureCode(IdManCode, ManufactureName)
VALUES (mancode_seq.nextval, 'Fajrero');
INSERT INTO ManufactureCode(IdManCode, ManufactureName)
VALUES (mancode_seq.nextval, 'CC fireworks');
INSERT INTO ManufactureCode(IdManCode, ManufactureName)
VALUES (mancode_seq.nextval, 'Funny Story');
INSERT INTO ManufactureCode(IdManCode, ManufactureName)
VALUES (mancode_seq.nextval, 'Giant Dragon');



-- ITEMTYPE ENTITY
CREATE SEQUENCE itemtype_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO ItemType(IdItemType, ItemTypeName)
VALUES (itemtype_seq.nextval, 'firecrackers');
INSERT INTO ItemType(IdItemType, ItemTypeName)
VALUES (itemtype_seq.nextval, 'smokes');
INSERT INTO ItemType(IdItemType, ItemTypeName)
VALUES (itemtype_seq.nextval, 'cracker');
INSERT INTO ItemType(IdItemType, ItemTypeName)
VALUES (itemtype_seq.nextval, 'fountains');
INSERT INTO ItemType(IdItemType, ItemTypeName)
VALUES (itemtype_seq.nextval, 'rockets');
INSERT INTO ItemType(IdItemType, ItemTypeName)
VALUES (itemtype_seq.nextval, 'cakes');


-- PYMENTTYPE ENTITY
CREATE SEQUENCE paymenttype_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO PaymentType(IdPaymentType, PaymentName, Description)
VALUES (paymenttype_seq.nextval, 'Bank card', NULL);
INSERT INTO PaymentType(IdPaymentType, PaymentName, Description)
VALUES (paymenttype_seq.nextval, 'Electronic payment system', NULL);
INSERT INTO PaymentType(IdPaymentType, PaymentName, Description)
VALUES (paymenttype_seq.nextval, 'Translation', 'Can be made only after receiving the order!');
INSERT INTO PaymentType(IdPaymentType, PaymentName, Description)
VALUES (paymenttype_seq.nextval, 'Cash payment', NULL);



-- EMP ENTITY
CREATE SEQUENCE emp_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Anna', 'Kotiun', '+380955470643', '43021, N.Burchaka 14 st., Lutsk/Ukraine', TO_DATE('1995-12-14', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Svitlana', 'Melnik', '+380668353559', '43025, Vidrodzenia 1/12a av., Kyiv/Ukraine', TO_DATE('1970-01-12', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Serhii', 'Somko', '+3809756845674', '21087, Samotnowicha 122/3n av., Poltava/Ukraine', TO_DATE('1970-03-05', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Asya', 'Sikocha', '+380956578877', '00098, Harmonii 56a/1 st., Minsk/Bielarus', TO_DATE('1989-11-01', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Iliya', 'Matusievich', '+56709877466', '98778, Ratusha 3 sq., Minsk/Bielarus', TO_DATE('2000-03-31', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Vadzim', 'Alushko', '+45667776555', '00456, Wielichanska 12/12 st., Brest/Bielarus', TO_DATE('1999-10-15', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Mariia', 'Okunevich', '+480665566554', '01-223, Wilcza 11/2a st., Warsaw/Poland', TO_DATE('2001-12-25', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Pawel', 'Wnuczko', '+45667332221', '01-455, Chomowska 11 st., Chelm/Poland', TO_DATE('1982-05-14', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Andriy', 'Nawalnyi', '+28809945477', '123-433, Ivana Groznogo 21 st., Moskow/Russia', TO_DATE('1976-02-28', 'YYYY-MM-DD'));
INSERT INTO Emp(IdEmp, FirstName, SecondName, PhoneNumber, Address, DoB)
VALUES (emp_seq.nextval, 'Alla', 'Musina', '+4557889887', '001-456, Poturowicha 12/554 av., Ekatirinburg/Russia', TO_DATE('1991-11-15', 'YYYY-MM-DD'));


-- STORAGELOCATION ENTITY
CREATE SEQUENCE storeloc_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO StorageLocation(IdStorageLocation, IdEmp, Address, PhoneNumber)
VALUES (storeloc_seq.nextval, 2, '34987, Separatska 11 av., Kyiv/Ukraine', '+3809934322');
INSERT INTO StorageLocation(IdStorageLocation, IdEmp, Address, PhoneNumber)
VALUES (storeloc_seq.nextval, 5, '45688, Sybecka 122/1 st., Minsk/Bielarus', '+3456678876');
INSERT INTO StorageLocation(IdStorageLocation, IdEmp, Address, PhoneNumber)
VALUES (storeloc_seq.nextval, 7, '05-456, Konarskiego 12 st., Warsaw/Poland', '+4898230444');
INSERT INTO StorageLocation(IdStorageLocation, IdEmp, Address, PhoneNumber)
VALUES (storeloc_seq.nextval, 9, '567-888, Molodych Soldat 13/1 st., Moskow/Russia', '+2889876678');


-- CUSTOMER ENTITY
CREATE SEQUENCE customer_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO Customer(IdCustomer, IdStatus, FirstName, SecondName, Email, Address, DoB)
VALUES (customer_seq.nextval, 2, 'Victor', 'Malko', 'malko@gmail.com', '85-233, ul. Smolenska 5, Warsaw/Poland', TO_DATE('1991-11-15', 'YYYY-MM-DD'));
INSERT INTO Customer(IdCustomer, IdStatus, FirstName, SecondName, Email, Address, DoB)
VALUES (customer_seq.nextval, 3, 'Piotr', 'Kalko', 'p678ahh@gmail.com', 'ul. Ksiedza Siemaszki Kazimierza 150, Krakow/Poland', TO_DATE('1987-10-03', 'YYYY-MM-DD'));
INSERT INTO Customer(IdCustomer, IdStatus, FirstName, SecondName, Email, Address, DoB)
VALUES (customer_seq.nextval, 4, 'Andzej', 'Kikula', 'andkik@gmail.com', 'ul. Mloda 70, Warsaw/Poland', TO_DATE('1977-01-13', 'YYYY-MM-DD'));
INSERT INTO Customer(IdCustomer, IdStatus, FirstName, SecondName, Email, Address, DoB)
VALUES (customer_seq.nextval, 1, 'Annetta', 'Martonko', 'myhoobyisl@ukr.net', 'ul. Mloda 70, Kcharkow/Ukraine', TO_DATE('1973-05-23', 'YYYY-MM-DD'));
INSERT INTO Customer(IdCustomer, IdStatus, FirstName, SecondName, Email, Address, DoB)
VALUES (customer_seq.nextval, 1, 'Kozi', 'Walko', 'notomu@gmail.com', 'ul. Mavrykija 2, Lion/France', TO_DATE('1993-09-18', 'YYYY-MM-DD'));
INSERT INTO Customer(IdCustomer, IdStatus, FirstName, SecondName, Email, Address, DoB)
VALUES (customer_seq.nextval, 5, 'Mychail', 'Kirkorow', 'kakaki@gmail.com', 'ul. Soratowska 2, Soratow/Russia', TO_DATE('2000-12-28', 'YYYY-MM-DD'));
INSERT INTO Customer(IdCustomer, IdStatus, FirstName, SecondName, Email, Address, DoB)
VALUES (customer_seq.nextval, 2, 'Sandra', 'Mamala', 'mamalsa@somi.bel', 'ul. Domoroda 44, Misl/Bielarus', TO_DATE('1994-12-14', 'YYYY-MM-DD'));
INSERT INTO Customer(IdCustomer, IdStatus, FirstName, SecondName, Email, Address, DoB)
VALUES (customer_seq.nextval, 3, 'Soneb', 'Abducak', 'ac123i@gmail.com', 'pl. Sinatravska 12, Lutsk/Ukraine', TO_DATE('1985-09-28', 'YYYY-MM-DD'));


-- ITEM ENTITY
CREATE SEQUENCE item_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 1, 1, 1, 'p2000', 2, '$ price / one package - 20 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 2, 1, 3, 'Bullet Proof -4', 3, '$ price / one package - 10 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 3, 1, 4, 'Petardy11', 1, '$ price / one package - 10 zts / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 3, 1, 2, 'Petardy11', 1, '$ price / one package - 10 zts / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 2, 1, 1, 'Fallinf lights', 4, '$ price / one package - 30 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 5, 1, 2, 'Screaming', 1, '$ price / one package - 3 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 1, 1, 4, 'Srebne sztuki', 3, '$ price / one package - 12 zts /only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 2, 2, 3, 'DYM', 5, '$ price / one package - 1 zts / white, red, green, blue, black / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 4, 3, 1, 'Dollars', 2, '$ price / one package - 1 zts / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 4, 3, 2, 'Dollars', 2, '$ price / one package - 1 zts / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 3, 3, 3, 'Hearts', 2, '$ price / one package - 1 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 5, 3, 4, 'Lights', 2, '$ price / one package - 1 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 1, 4, 1, 'Fontana', 4, '$ price / one package - 4 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 2, 4, 2, 'Star Fontain', 10, '$ price / one package - 12 zts / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 5, 4, 3, 'Star Fontain', 10, '$ price / one package - 12 zts / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 2, 5, 4, 'Sky rocket', 7, '$ price / one package - 16 zts / 4|4 with different effects / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 4, 5, 2, 'Purple rain', 3, '$ price / one package - 3 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 1, 5, 1, 'Gold rain/2', 15, '$ price / one package - 7 zts / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 3, 6, 1, 'Red brocade', 20, '$ price / one package - 1 zts / 9 shots, 20'' / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 2, 6, 3, 'Sexy snow', 35, '$ price / one package - 1 zts / 36 shots, 25'' / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 5, 6, 2, 'Shatter', 40, '$ price / one package - 1 zts / 121 shots, 20'' / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 5, 6, 1, 'Shatter', 20, '$ price (changed price) / one package - 1 zts / 121 shots, 20'' / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 5, 6, 3, 'Shatter', 40, '$ price / one package - 1 zts / 121 shots, 20'' / not only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 4, 6, 4, 'Olimpic', 30, '$ price / one package - 1 zts / 88 shots, 25'' / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 3, 6, 2, 'Bling', 47, '$ price / one package - 1 zts / 49 shots, 35'' / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 2, 6, 1, 'Big Boom', 53, '$ price / one package - 1 zts / 55 shots, 30'' / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 1, 6, 3, 'Santa', 23, '$ price / one package - 1 zts / 30 shots, 25'' / only on this storage');
INSERT INTO Item(IdItem, IdManCode, IdItemType, IdStorageLocation, ItemName, Price, Description)
VALUES (item_seq.nextval, 3, 6, 2, 'Rainbow', 35, '$ price / one package - 1 zts / 43 shots, 15'' / only on this storage');


-- BuyingTransaction ENTITY
CREATE SEQUENCE trans_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO BuyingTransaction(IdBuyingTransaction, IdPaymentType, IdCustomer, IdEmp, DateTrans, Description)
VALUES (trans_seq.nextval, 1, 2, 7, TO_DATE('2019-11-13', 'YYYY-MM-DD'), NULL);
INSERT INTO BuyingTransaction(IdBuyingTransaction, IdPaymentType, IdCustomer, IdEmp, DateTrans, Description)
VALUES (trans_seq.nextval, 3, 4, 3, TO_DATE('2019-11-25', 'YYYY-MM-DD'), 'add an extra instruction');
INSERT INTO BuyingTransaction(IdBuyingTransaction, IdPaymentType, IdCustomer, IdEmp, DateTrans, Description)
VALUES (trans_seq.nextval, 2, 5, 7, TO_DATE('2019-12-03', 'YYYY-MM-DD'), NULL);
INSERT INTO BuyingTransaction(IdBuyingTransaction, IdPaymentType, IdCustomer, IdEmp, DateTrans, Description)
VALUES (trans_seq.nextval, 1, 7, 5, TO_DATE('2019-12-17', 'YYYY-MM-DD'), 'to add a present package');
INSERT INTO BuyingTransaction(IdBuyingTransaction, IdPaymentType, IdCustomer, IdEmp, DateTrans, Description)
VALUES (trans_seq.nextval, 4, 6, 8, TO_DATE('2019-12-30', 'YYYY-MM-DD'), NULL);
INSERT INTO BuyingTransaction(IdBuyingTransaction, IdPaymentType, IdCustomer, IdEmp, DateTrans, Description)
VALUES (trans_seq.nextval, 1, 6, 8, TO_DATE('2020-01-08', 'YYYY-MM-DD'), NULL);
INSERT INTO BuyingTransaction(IdBuyingTransaction, IdPaymentType, IdCustomer, IdEmp, DateTrans, Description)
VALUES (trans_seq.nextval, 1, 2, 8, TO_DATE('2020-01-22', 'YYYY-MM-DD'), NULL);


-- Action ENTITY
CREATE SEQUENCE action_seq
START WITH     1
INCREMENT BY   1;

INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 1, 22, 1);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 2, 3, 2);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 2, 5, 1);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 3, 27, 1);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 4, 20, 1);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 4, 13, 6);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 5, 27, 3);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 6, 11, 7);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 6, 13, 20);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 7, 26, 1);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 7, 2, 1);
INSERT INTO Action(IdAction, IdBuyingTransaction, IdItem, Quantity)
VALUES (action_seq.nextval, 7, 4, 2);

/

--BEFORE statement trigger for each row

--Before updating "Address" in the Customer table we add an info about modifications to the table CustomerHistory.
--Before updating "Email" in the Customer table we add an info about modifications to the table CustomerHistory.
--Updating of the email of the Customer with idStatus = 1 is not allowed.
--There's an error raised, if you try to UPDATE "IdCustomer"
--Also trigger prints the message about modifications

Set serveroutput on;

CREATE OR REPLACE TRIGGER MyTrigger
BEFORE UPDATE OF idcustomer, email, address ON Customer
FOR EACH ROW
DECLARE 
history int;
descript varchar2(100);
exc_Err EXCEPTION;

BEGIN
    
SELECT NVL(MAX(IdHistory)+1, 1) into history 
FROM CustomerHistory; --calculating Primary Key

    IF UPDATING('idcustomer') THEN
            RAISE exc_Err;
    ELSIF UPDATING ('email') THEN
        IF :old.idstatus = 1 THEN
            :new.email := :old.email;
            dbms_output.put_line('Info about the email of the ' || :old.IdCustomer ||' was not changed');
        ELSE
            descript:= 'OLD: ' || :old.Email || ' | NEW: ' || :new.Email;
            dbms_output.put_line('Info about the email of the ' || :old.IdCustomer ||' customer is added to CustomerHistory table');
            
            INSERT INTO CustomerHistory(IdHistory, IdCustomer, dateHis, Changes)
            VALUES (history, :old.IdCustomer, sysdate(), descript);        
        END IF;
    ELSIF UPDATING ('address') THEN
            descript:= 'OLD: ' || :old.Address || ' | NEW: ' || :new.Address;
            dbms_output.put_line('Info about the address of the ' || :old.IdCustomer ||' customer is added to CustomerHistory table');
            INSERT INTO CustomerHistory(IdHistory, IdCustomer, dateHis, Changes)
            VALUES (history, :old.IdCustomer, sysdate(), descript);    
    END IF;
    EXCEPTION
    WHEN exc_Err THEN --custom exception
    :new.idcustomer := :old.idcustomer;
        dbms_output.put_line('!It is forbidden to change IdCustomer!'); 
END;
/

UPDATE Customer
SET email = 'nwhjk@gmail.com'
WHERE idcustomer = 4;

UPDATE Customer
SET address = 'Newcity'
WHERE idcustomer = 2;

UPDATE Customer
SET idcustomer = 17
WHERE idcustomer = 1;

Select* from Customer;
--Here you can check the history
SELECT *
FROM CustomerHistory;
/

-- procedure with output 
CREATE OR REPLACE PROCEDURE ItemNew
    (code INTEGER,
    iname varchar)
AS
    checkNo INTEGER;
    iid INTEGER;
    itype INTEGER;
    istorage INTEGER;
    ipri INTEGER;
    
BEGIN

SELECT COUNT(*) INTO checkNo
FROM ManufactureCode
WHERE IdManCode = code;
    
    IF checkNo = 0 THEN
        RAISE_APPLICATION_ERROR(-20201, 'MANUFACTURE DOES NOT EXIST');
    ELSE
    
    --id
    SELECT NVL(MAX(iditem) + 1, 1) into iid
    FROM Item;
    
    --type
    SELECT iditemtype into itype
    FROM Item
    GROUP BY iditemtype
    HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM Item GROUP BY iditemtype); --type with max number of items
    
    --storage
    SELECT MIN(idstoragelocation) into istorage
    FROM Item;
    
    --pri
    SELECT FLOOR(AVG(price)) into ipri
    FROM Item 
    WHERE Iditemtype = itype;
    
    INSERT INTO Item VALUES (iid, code, itype, istorage, iname, ipri, null);
    
    dbms_output.put_line('** New Item N' || iid || ' with "' || iname || '" name and a price '|| ipri || '$ **');

    END IF;

END ItemNew;
/
CALL ItemNew(4, 'New');

SELECT * FROM ITEM;


/
-- 1 object with cursor (other than procedure and trigger from above)

CREATE OR REPLACE FUNCTION Reduce
RETURN INTEGER
AS
av INTEGER;
v_id INTEGER;
v_name VARCHAR2(50);
v_price INTEGER;
CURSOR curs IS SELECT IdItem, ItemName, Price --3 greatest prices
FROM Item i
WHERE 4>(SELECT COUNT(*) FROM Item WHERE price>i.price);
BEGIN
    SELECT AVG(price) INTO av FROM Item;
     OPEN curs;
     LOOP
        FETCH curs INTO v_id, v_name, v_price;
        EXIT WHEN curs%NOTFOUND;
            IF v_price > av THEN
                UPDATE Item
                SET Price = FLOOR(v_price*0.9)
                WHERE IdItem = v_id;
                dbms_output.put_line('**The price of the item N' || v_id ||' "' || v_name || '" was decreased to ' || v_price*0.9 ||'**');
            ELSE
                UPDATE Item
                SET Price = FLOOR(v_price*1.1)
                WHERE IdItem = v_id;
                dbms_output.put_line('**The price of the item "' || v_name || '" was increased to ' || v_price*1.1 || '**');
            END IF;    
            
        END LOOP;
        return curs%ROWCOUNT;
        CLOSE curs;
END Reduce;
/

DECLARE 
   v INTEGER;
BEGIN
    v:= Reduce;
    dbms_output.put_line(v ||' rows were updated');
END;

/
SELECT * FROM ITEM;


