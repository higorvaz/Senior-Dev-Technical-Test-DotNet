-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- Bank.dbo.Bank definition

-- Drop table

-- DROP TABLE Bank.dbo.Bank;

CREATE TABLE Bank.dbo.Bank (
	BankID int IDENTITY(0,1) NOT NULL,
	BankName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT Bank_UN UNIQUE (BankName),
	CONSTRAINT Banks_PK PRIMARY KEY (BankID)
);
CREATE UNIQUE NONCLUSTERED INDEX Bank_UN ON Bank.dbo.Bank (BankName);
 CREATE  UNIQUE NONCLUSTERED INDEX Banks_BankID_IDX ON dbo.Bank (  BankID ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- Bank.dbo.TraderCategory definition

-- Drop table

-- DROP TABLE Bank.dbo.TraderCategory;

CREATE TABLE Bank.dbo.TraderCategory (
	TraderCategoryID int IDENTITY(0,1) NOT NULL,
	TraderCategoryName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT TraderCategory_PK PRIMARY KEY (TraderCategoryID),
	CONSTRAINT TraderCategory_UN UNIQUE (TraderCategoryName)
);
CREATE UNIQUE NONCLUSTERED INDEX TraderCategory_UN ON Bank.dbo.TraderCategory (TraderCategoryName);


-- Bank.dbo.TraderCategoryRule definition

-- Drop table

-- DROP TABLE Bank.dbo.TraderCategoryRule;

CREATE TABLE Bank.dbo.TraderCategoryRule (
	TraderCategoryRuleID int IDENTITY(0,1) NOT NULL,
	TraderCategoryRuleName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	TraderCategoryRuleLessGreater smallint DEFAULT 0 NOT NULL,
	TraderCategoryRuleValue money NOT NULL,
	TraderCategoryRuleValue_ decimal(38,0) NULL,
	TraderCategoryRuleDescription varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TraderCategoryRuleSector int DEFAULT 0 NOT NULL,
	CONSTRAINT TraderCategoryRule_PK PRIMARY KEY (TraderCategoryRuleID),
	CONSTRAINT TraderCategoryRule_UN UNIQUE (TraderCategoryRuleName)
);
 CREATE NONCLUSTERED INDEX TraderCategoryRule_TraderCategoryRuleLessGreater_IDX ON dbo.TraderCategoryRule (  TraderCategoryRuleLessGreater ASC  , TraderCategoryRuleValue ASC  , TraderCategoryRuleValue_ ASC  , TraderCategoryRuleSector ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX TraderCategoryRule_TraderCategoryRuleSector_IDX ON dbo.TraderCategoryRule (  TraderCategoryRuleSector ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX TraderCategoryRule_TraderCategoryRuleValue_IDX ON dbo.TraderCategoryRule (  TraderCategoryRuleValue ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX TraderCategoryRule_TraderCategoryRuleValue__IDX ON dbo.TraderCategoryRule (  TraderCategoryRuleValue_ ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
CREATE UNIQUE NONCLUSTERED INDEX TraderCategoryRule_UN ON Bank.dbo.TraderCategoryRule (TraderCategoryRuleName);


-- Bank.dbo.BankTrader definition

-- Drop table

-- DROP TABLE Bank.dbo.BankTrader;

CREATE TABLE Bank.dbo.BankTrader (
	TraderID int IDENTITY(0,1) NOT NULL,
	TraderSector smallint DEFAULT 0 NOT NULL,
	TraderName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	BankID int NULL,
	CONSTRAINT BankTrader_PK PRIMARY KEY (TraderID),
	CONSTRAINT BankTrader_FK FOREIGN KEY (BankID) REFERENCES Bank.dbo.Bank(BankID)
);


-- Bank.dbo.TraderTransaction definition

-- Drop table

-- DROP TABLE Bank.dbo.TraderTransaction;

CREATE TABLE Bank.dbo.TraderTransaction (
	TransactionID int IDENTITY(0,1) NOT NULL,
	TransactionName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	TraderID int NULL,
	TransactionValue decimal(38,0) NULL,
	TransactionValue_ money NULL,
	CONSTRAINT TraderTransaction_PK PRIMARY KEY (TransactionID),
	CONSTRAINT TraderTransaction_FK FOREIGN KEY (TraderID) REFERENCES Bank.dbo.BankTrader(TraderID)
);
 CREATE NONCLUSTERED INDEX TraderTransaction_TraderID_IDX ON dbo.TraderTransaction (  TraderID ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX TraderTransaction_TransactionValue_IDX ON dbo.TraderTransaction (  TransactionValue ASC  , TransactionValue_ ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX TraderTransaction_TransactionValue__IDX ON dbo.TraderTransaction (  TransactionValue_ ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- dbo.VWRISKS source

-- dbo.VWRISKS source

-- dbo.VWRISKS source

-- dbo.NewView source

CREATE VIEW dbo.VWRISKS AS
SELECT
	bt.TraderName,
	CASE
		WHEN bt.[TraderSector] = 0 
  THEN 'Public'
		ELSE 'Private'
	END AS 'TraderSector',
	(
	SELECT
		TOP 1
 TraderCategoryRuleName
	FROM
		TraderCategoryRule
	WHERE
		TraderCategoryRuleSector = bt.[TraderSector]
		AND 
tr.[TransactionValue] >= TraderCategoryRuleValue
		AND
TraderCategoryRuleLessGreater = 1
		OR

TraderCategoryRuleSector = bt.[TraderSector]
		AND 
tr.[TransactionValue] <= TraderCategoryRuleValue
		AND
TraderCategoryRuleLessGreater = 0
	ORDER BY
		TraderCategoryRuleName

) AS 'Risk',
tr.TransactionValue

	FROM
[dbo].[TraderTransaction] tr
INNER JOIN [dbo].[BankTrader] bt 
ON bt.[TraderID] = tr.[TraderID]
;
