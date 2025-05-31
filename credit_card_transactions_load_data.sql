USE transactions;
CREATE TABLE credit_card_transcations(
	transaction_id smallint not null,
	city nvarchar(50) not null,
	transaction_date date not null,
	card_type nvarchar(50) not null,
	exp_type nvarchar(50) not null,
	gender nvarchar(50) not null,
	amount int not null
);


BULK INSERT credit_card_transcations
FROM 'C:\\Users\\wasil\\Downloads\\credit_card_transcations.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

select * from credit_card_transcations