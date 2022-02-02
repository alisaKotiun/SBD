-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-01-24 20:54:27.047

-- tables
-- Table: Action
CREATE TABLE Action (
    IdAction int  NOT NULL,
    IdBuyingTransaction int  NOT NULL,
    IdItem int  NOT NULL,
    Quantity int  NOT NULL,
    CONSTRAINT Action_pk PRIMARY KEY  (IdAction)
);

-- Table: BuyingTransaction
CREATE TABLE BuyingTransaction (
    IdBuyingTransaction int  NOT NULL,
    IdPaymentType int  NOT NULL,
    IdCustomer int  NOT NULL,
    IdEmp int  NOT NULL,
    DateTrans date  NOT NULL,
    CONSTRAINT BuyingTransaction_pk PRIMARY KEY  (IdBuyingTransaction)
);

-- Table: Customer
CREATE TABLE Customer (
    IdCustomer int  NOT NULL,
    IdStatus int  NOT NULL,
    FirstName varchar(50)  NOT NULL,
    LastName varchar(50)  NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY  (IdCustomer)
);

-- Table: Emp
CREATE TABLE Emp (
    IdEmp int  NOT NULL,
    FirstName varchar(50)  NOT NULL,
    LastName varchar(50)  NOT NULL,
    DoB date  NOT NULL,
    CONSTRAINT Emp_pk PRIMARY KEY  (IdEmp)
);

-- Table: Item
CREATE TABLE Item (
    IdItem int  NOT NULL,
    IdManCode int  NOT NULL,
    IdItemType int  NOT NULL,
    IdStorageLocation int  NOT NULL,
    Name varchar(50)  NOT NULL,
    Price int  NOT NULL,
    CONSTRAINT Item_pk PRIMARY KEY  (IdItem)
);

-- Table: ItemType
CREATE TABLE ItemType (
    IdItemType int  NOT NULL,
    Name varchar(50)  NOT NULL,
    CONSTRAINT ItemType_pk PRIMARY KEY  (IdItemType)
);

-- Table: ManufactureCode
CREATE TABLE ManufactureCode (
    IdManCode int  NOT NULL,
    Name varchar(50)  NOT NULL,
    CONSTRAINT ManufactureCode_pk PRIMARY KEY  (IdManCode)
);

-- Table: PaymentType
CREATE TABLE PaymentType (
    IdPaymentType int  NOT NULL,
    Name varchar(30)  NOT NULL,
    CONSTRAINT PaymentType_pk PRIMARY KEY  (IdPaymentType)
);

-- Table: Status
CREATE TABLE Status (
    IdStatus int  NOT NULL,
    Name varchar(50)  NOT NULL,
    CONSTRAINT Status_pk PRIMARY KEY  (IdStatus)
);

-- Table: StorageLocation
CREATE TABLE StorageLocation (
    IdStorageLocation int  NOT NULL,
    IdEmp int  NOT NULL,
    Address varchar(50)  NOT NULL,
    CONSTRAINT StorageLocation_pk PRIMARY KEY  (IdStorageLocation)
);

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

-- sequences
-- Sequence: action_seq
CREATE SEQUENCE action_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: customer_seq
CREATE SEQUENCE customer_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: emp_seq
CREATE SEQUENCE emp_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: item_seq
CREATE SEQUENCE item_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: itemtype_seq
CREATE SEQUENCE itemtype_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: mancode_seq
CREATE SEQUENCE mancode_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: paymenttype_seq
CREATE SEQUENCE paymenttype_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: status_seq
CREATE SEQUENCE status_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: storeloc_seq
CREATE SEQUENCE storeloc_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: trans_seq
CREATE SEQUENCE trans_seq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- End of file.

