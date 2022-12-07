CREATE DATABASE ABay;
CREATE USER 'webapp'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON ABay.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE ABay;

CREATE TABLE Admin (
  adminID INT AUTO_INCREMENT NOT NULL,
  username VARCHAR(25),
  password VARCHAR(50),
  account_age INT NOT NULL,
  CONSTRAINT pk PRIMARY KEY (adminID)
);

CREATE TABLE VendorBans (
  banID INT AUTO_INCREMENT NOT NULL,
  vendorID INT NOT NULL,
  unbanTime INT,
  banReason VARCHAR(100),
  adminID INT NOT NULL,
  CONSTRAINT pk PRIMARY KEY (adminID),
  CONSTRAINT fk1 FOREIGN KEY (vendorID)
    REFERENCES Seller (SellerID)
    ON UPDATE CASCADE,
  CONSTRAINT fk2 FOREIGN KEY (adminID)
    REFERENCES Admin (adminID)
    ON UPDATE CASCADE
);

CREATE TABLE CustomerBans (
  banID INT AUTO_INCREMENT NOT NULL,
  custID INT NOT NULL,
  unbanTime INT,
  banReason VARCHAR(100),
  adminID INT NOT NULL,
  CONSTRAINT pk PRIMARY KEY (adminID),
  CONSTRAINT fk1 FOREIGN KEY (custID)
    REFERENCES Buyer (BuyerID)
    ON UPDATE CASCADE,
  CONSTRAINT fk2 FOREIGN KEY (adminID)
    REFERENCES Admin (adminID)
    ON UPDATE CASCADE
);


CREATE TABLE Seller (
  SellerID INT AUTO_INCREMENT NOT NULL,
  AdministratorID INT NOT NULL,
  InfoID INT NOT NULL,
  CONSTRAINT pk PRIMARY KEY (SellerID),

  CONSTRAINT fk1 FOREIGN KEY (AdministratorID)
    REFERENCES Admin (adminID)
    ON UPDATE CASCADE,
  CONSTRAINT fk2 FOREIGN KEY (InfoID)
    REFERENCES UserInfo (InfoID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Past_Sales (
  ProductID INT NOT NULL,
  SellerID INT NOT NULL,
  FulfillDate INT NOT NULL,
  Quantity INT NOT NULL,
  CONSTRAINT pk PRIMARY KEY (ProductID, SellerID),

  CONSTRAINT fk1 FOREIGN KEY (ProductID)
    REFERENCES Products (listingID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk2 FOREIGN KEY (SellerID)
    REFERENCES Seller (SellerID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Orders (
  OrderID INT AUTO_INCREMENT NOT NULL,
  SellerID INT NOT NULL,
  ProductID INT NOT NULL,
  CustAddress VARCHAR(100) NOT NULL,
  FulfillmentDate DATE,
  FulfillmentStatus DATE,
  ListQuantity INT NOT NULL,
  ListPrice INT NOT NULL,
  BuyerID INT NOT NULL,
  CONSTRAINT pk PRIMARY KEY (OrderID),

  CONSTRAINT fk1 FOREIGN KEY (ProductID)
    REFERENCES Products (listingID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk2 FOREIGN KEY (SellerID)
    REFERENCES Seller (SellerID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk3 FOREIGN KEY (BuyerID)
    REFERENCES Buyer (BuyerID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE UserInfo (
  InfoID INT AUTO_INCREMENT NOT NULL,
  Address VARCHAR(250),
  Name VARCHAR(50),
  username VARCHAR(50),
  password VARCHAR(50),
  CONSTRAINT pk PRIMARY KEY (InfoID),
);

CREATE TABLE Products (
  ProductID INT AUTO_INCREMENT NOT NULL,
  SellerID INT NOT NULL,
  Quantity INT NOT NULL,
  Sale_start DATE,
  Sale_end DATE,
  ProductTypeID INT NOT NULL,
  unitPrice INT NOT NULL,
  CONSTRAINT pk PRIMARY KEY (ProductID),

  CONSTRAINT fk1 FOREIGN KEY (SellerID)
    REFERENCES Seller (SellerID)
    ON UPDATE CASCADE,
  CONSTRAINT fk2 FOREIGN KEY (ProductTypeID)
    REFERENCES ProductType (TypeID)
    ON UPDATE CASCADE
);

CREATE TABLE ProductType (
  TypeID INT AUTO_INCREMENT NOT NULL,
  TypeName VARCHAR(50),
  CONSTRAINT pk PRIMARY KEY (TypeID),
);

CREATE TABLE Buyer (
  BuyerID INT AUTO_INCREMENT NOT NULL,
  Email VARCHAR(50),
  UserInfoID INT NOT NULL,
  CONSTRAINT pk PRIMARY KEY (BuyerID),

  CONSTRAINT fk1 FOREIGN KEY (UserInfoID)
    REFERENCES UserInfo (InfoID)
    ON UPDATE CASCADE
);




INSERT INTO test_table
  (name, color)
VALUES
  ('dev', 'blue'),
  ('pro', 'yellow'),
  ('junior', 'red');
