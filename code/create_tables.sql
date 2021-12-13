DROP TABLE BD_2.COUNTRY CASCADE CONSTRAINTS;
DROP TABLE BD_2.CITY CASCADE CONSTRAINTS;
DROP TABLE BD_2.POSTAL_CODE CASCADE CONSTRAINTS;
DROP TABLE BD_2.ADDRESS CASCADE CONSTRAINTS;
DROP TABLE BD_2.PERSON CASCADE CONSTRAINTS;
DROP TABLE BD_2.PHONE;
DROP TABLE BD_2.ROLE_T CASCADE CONSTRAINTS;
DROP TABLE BD_2.ROLES_T;
DROP TABLE BD_2.COLOR CASCADE CONSTRAINTS;
DROP TABLE BD_2.PRODUCER CASCADE CONSTRAINTS;
DROP TABLE BD_2.PRODUCT_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE BD_2.ABSTRACT_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE BD_2.PRODUCT_SPECIMEN CASCADE CONSTRAINTS;
DROP TABLE BD_2.TRANSACTION_T CASCADE CONSTRAINTS;
DROP TABLE BD_2.ORDERED_PRODUCTS CASCADE CONSTRAINTS;
DROP TABLE BD_2.PROMOTION CASCADE CONSTRAINTS;

CREATE TABLE BD_2.COUNTRY(
	ID NUMBER(10) CONSTRAINT COUNTRY_ID_PK PRIMARY KEY,
	NAME VARCHAR2(56) NOT NULL
);

CREATE TABLE BD_2.CITY(
	ID NUMBER(10) CONSTRAINT CITY_ID_PK PRIMARY KEY,
	COUNTRY_ID NUMBER(10) NOT NULL,
	NAME VARCHAR2(20) NOT NULL,
	STATE_V VARCHAR2(20) NOT NULL
);

CREATE TABLE BD_2.POSTAL_CODE(
	ID NUMBER(10) CONSTRAINT POSTAL_CODE_ID_PK PRIMARY KEY,
	CODE CHAR(6) NOT NULL
);

CREATE TABLE BD_2.ADDRESS(
	ID NUMBER(10) CONSTRAINT ADDRESS_ID_PK PRIMARY KEY,
	CITY_ID NUMBER(10) NOT NULL,
	POSTAL_CODE_ID NUMBER(10) NOT NULL,
	STREET_NUMBER VARCHAR2(10) NOT NULL,
	FLAT_NUMBER VARCHAR2(10),
	STREET_NAME VARCHAR2(100)
);

CREATE TABLE BD_2.PERSON(
	ID NUMBER(10) CONSTRAINT PERSON_ID_PK PRIMARY KEY,
	ADDRESS_ID NUMBER(10) NOT NULL,
	FIRSTNAME VARCHAR2(100) NOT NULL,
	SURNAME VARCHAR2(100) NOT NULL,
	E_MAIL VARCHAR2(255) NOT NULL,
	USERNAME VARCHAR2(100) NOT NULL,
	PASSWORD CHAR(255) NOT NULL,
	CREATION_DATE DATE NOT NULL,
	HIRING_DATE DATE,
	EMPLOYEE_NUMBER NUMBER(10),
	REGULAR_CUSTOMER NUMBER(1),
	CONSTRAINT CHECK_E_MAIL CHECK(E_MAIL LIKE '%_@_%._%'),
	CONSTRAINT CHECK_REGULAR_CUSTOMER CHECK(REGULAR_CUSTOMER IN (0,1))
);

CREATE TABLE BD_2.PHONE(
	ID NUMBER(10) CONSTRAINT PHONE_ID_PK PRIMARY KEY,
	PERSON_ID NUMBER(10) NOT NULL,
	PHONE_NUMBER VARCHAR2(20) NOT NULL,
	IS_EMPLOYEE_PHONE NUMBER(1) NOT NULL,
	CONSTRAINT CHECK_IS_EMPLOYEE_PHONE CHECK(IS_EMPLOYEE_PHONE IN (0,1))
);

CREATE TABLE BD_2.ROLE_T(
	ID NUMBER(10) CONSTRAINT ROLE_ID_PK PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL
);

CREATE TABLE BD_2.ROLES_T(
	PERSON_ID NUMBER(10) NOT NULL,
	ROLE_ID NUMBER(10) NOT NULL
);

CREATE TABLE BD_2.COLOR(
	ID NUMBER(10) CONSTRAINT COLOR_ID_PK PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL
);

CREATE TABLE BD_2.PRODUCER(
	ID NUMBER(10) CONSTRAINT PRODUCER_ID_PK PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL
);

CREATE TABLE BD_2.PRODUCT_CATEGORY(
	ID NUMBER(10) CONSTRAINT PRODUCT_CATEGORY_ID_PK PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL
);

CREATE TABLE BD_2.ABSTRACT_PRODUCT(
	ID NUMBER(10) CONSTRAINT ABSTRACT_PRODUCT_ID_PK PRIMARY KEY,
	PRODUCT_CATEGORY_ID NUMBER(10) NOT NULL,
	PRODUCER_ID NUMBER(10) NOT NULL,
	PRICE NUMBER(8,2) NOT NULL,
	NAME VARCHAR2(20) NOT NULL,
	DESCRIPTION VARCHAR2(255) NOT NULL,
	WEIGHT NUMBER(5,3),
	HEIGHT NUMBER(5),
	WIDTH NUMBER(5),
	TAX_VALUE NUMBER(3) NOT NULL,
	CONSTRAINT CHECK_PRICE CHECK(PRICE > 0),
	CONSTRAINT CHECK_WEIGHT CHECK(WEIGHT > 0 OR WEIGHT IS NULL),
	CONSTRAINT CHECK_HEIGHT CHECK(HEIGHT > 0 OR HEIGHT IS NULL),
	CONSTRAINT CHECK_WIDTH CHECK(WIDTH > 0 OR WIDTH IS NULL),
	CONSTRAINT CHECK_TAX_VALUE CHECK(TAX_VALUE > 0 AND TAX_VALUE <= 100)
);

CREATE TABLE BD_2.PRODUCT_SPECIMEN(
	ID NUMBER(10) CONSTRAINT PRODUCT_SPECIMEN_ID_PK PRIMARY KEY,
	ABSTRACT_PRODUCT_ID NUMBER(10) NOT NULL,
	COLOR_ID NUMBER(10) NOT NULL,
	IMAGE BLOB NOT NULL,
	PRODUCTION_DATE DATE,
	DESCRIPTION VARCHAR2(255),
	SERIAL_NUMBER NUMBER(10) NOT NULL UNIQUE,
	QUANTITY NUMBER(5) NOT NULL,
	CONSTRAINT CHECK_PRODUCT_QUANTITY CHECK(QUANTITY > 0)
);

CREATE TABLE BD_2.TRANSACTION_T(
	ID NUMBER(10) CONSTRAINT TRANSACTION_T_ID_PK PRIMARY KEY,
	ADDRESS_ID NUMBER(10) NOT NULL,
	CUSTOMER_ID NUMBER(10) NOT NULL,
	EMPLOYEE_ID NUMBER(10) NOT NULL,
	CREATION_DATE DATE NOT NULL,
	FINALIZED NUMBER(1),
	TRANSACTION_AMOUNT NUMBER(10, 2),
	CONSTRAINT CHECK_FINALIZED CHECK(FINALIZED IN (0,1)),
	CONSTRAINT CHECK_TRANSACTION_AMOUNT CHECK(TRANSACTION_AMOUNT > 0)
);

CREATE TABLE BD_2.ORDERED_PRODUCTS(
	TRANSACTION_ID NUMBER(10) NOT NULL,
	PRODUCT_SPECIMEN_ID NUMBER(10) NOT NULL,
	QUANTITY NUMBER(5) NOT NULL,
	PRICE_OF_ONE_PRODUCT NUMBER(8, 2) NOT NULL,
	CONSTRAINT CHECK_QUANTITY CHECK(QUANTITY > 0),
	CONSTRAINT CHECK_PRICE_OF_ONE_PRODUCT CHECK(PRICE_OF_ONE_PRODUCT > 0)
);


CREATE TABLE BD_2.PROMOTION(
	ID NUMBER(10) CONSTRAINT PROMOTION_ID_PK PRIMARY KEY,
	PRODUCT_CATEGORY_ID NUMBER(10),
	ABSTRACT_PRODUCT_ID NUMBER(10),
	PRODUCT_SPECIMEN_ID NUMBER(10),
	PERCENTAGE NUMBER(3) NOT NULL,
	START_DATE DATE,
	END_DATE DATE,
	CONSTRAINT CHECK_PERCENTAGE CHECK(PERCENTAGE > 0 AND PERCENTAGE <= 100)
);








