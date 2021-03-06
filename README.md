# Senior-Dev-Technical-Test-DotNet

Senior Dev Technical Test DotNet (All done on pure Ubuntu 21.10 Linux machine)

## Question 1.

Identify the categories of trades in a bank´s portfolio. A bank has a portfolio of thousands of trades and they need to be categorized.   
A trade is a commercial negotiation between a bank and a client.   
Each trade has a value that indicates the transaction amount in dollars and a text indicating if the client´s sector is "Public" or "Private".   
They implement the following interface:

`interface ITrade { double Value { get; } string ClientSector { get; } }`

Currently, there are three categories rules:   
LOWRISK: Trades with value less than 1,000,000 and client from Public Sector   
MEDIUMRISK: Trades with value greater than 1,000,000 and client from Public Sector   
HIGHRISK: Trades with value greater than 1,000,000 and client from Private Sector   
Imagine you receive a list of trades and you need to return a list of categories as below:

input: `List<ITrade> portfolio`  
output: `List<string> tradeCategories`

Example:  
Input:  
`Trade1 {Value = 2000000; ClientSector = "Private"}`  
`Trade2 {Value = 400000; ClientSector = "Public"}`  
`Trade3 {Value = 500000; ClientSector = "Public"}`  
`Trade4 {Value = 3000000; ClientSector = "Public"}`  
`portfolio = {Trade1, Trade2, Trade3, Trade4}`  
Output:  
`tradeCategories = {"HIGHRISK", "LOWRISK", "LOWRISK", "MEDIUMRISK"}`

Your design must take into account category rules can be added/removed/modified and will become highly complex in the near future. Please write your answer in C# showing clearly what classes, interfaces, methods and design patterns you would create/use to solve this problem. Also, object oriented programming is required. 

## Question 2.

 Write a procedural version of your solution for question 1, in T-SQL (SQL Server). Your procedure must write the inputs and outputs in one or more tables (model the table(s) using the best practices). Include the script to create the table(s) in your answer.

---

## Resolution

### Step 1: MS SQL image container

```
docker run -e "ACCEPT\_EULA=Y" -e "SA\_PASSWORD=PassWord232#" -p 1433:1433 -d mcr.microsoft.com/mssql/server:latest

```
#### Step 1.1: Database Schema

```
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
CREATE UNIQUE NONCLUSTERED INDEX Banks_BankID_IDX ON dbo.Bank ( BankID ASC )
WITH ( PAD_INDEX = OFF ,FILLFACTOR = 100 ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON )
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
CREATE NONCLUSTERED INDEX TraderCategoryRule_TraderCategoryRuleLessGreater_IDX ON dbo.TraderCategoryRule ( TraderCategoryRuleLessGreater ASC , TraderCategoryRuleValue ASC , TraderCategoryRuleValue_ ASC , TraderCategoryRuleSector ASC )
WITH ( PAD_INDEX = OFF ,FILLFACTOR = 100 ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON )
ON [PRIMARY ] ;
CREATE NONCLUSTERED INDEX TraderCategoryRule_TraderCategoryRuleSector_IDX ON dbo.TraderCategoryRule ( TraderCategoryRuleSector ASC )
WITH ( PAD_INDEX = OFF ,FILLFACTOR = 100 ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON )
ON [PRIMARY ] ;
CREATE NONCLUSTERED INDEX TraderCategoryRule_TraderCategoryRuleValue_IDX ON dbo.TraderCategoryRule ( TraderCategoryRuleValue ASC )
WITH ( PAD_INDEX = OFF ,FILLFACTOR = 100 ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON )
ON [PRIMARY ] ;
CREATE NONCLUSTERED INDEX TraderCategoryRule_TraderCategoryRuleValue__IDX ON dbo.TraderCategoryRule ( TraderCategoryRuleValue_ ASC )
WITH ( PAD_INDEX = OFF ,FILLFACTOR = 100 ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON )
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
CREATE NONCLUSTERED INDEX TraderTransaction_TraderID_IDX ON dbo.TraderTransaction ( TraderID ASC )
WITH ( PAD_INDEX = OFF ,FILLFACTOR = 100 ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON )
ON [PRIMARY ] ;
CREATE NONCLUSTERED INDEX TraderTransaction_TransactionValue_IDX ON dbo.TraderTransaction ( TransactionValue ASC , TransactionValue_ ASC )
WITH ( PAD_INDEX = OFF ,FILLFACTOR = 100 ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON )
ON [PRIMARY ] ;
CREATE NONCLUSTERED INDEX TraderTransaction_TransactionValue__IDX ON dbo.TraderTransaction ( TransactionValue_ ASC )
WITH ( PAD_INDEX = OFF ,FILLFACTOR = 100 ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON )
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
```

#### Step 1.2: Database Dump

```
INSERT INTO Bank.dbo.Bank (BankName) VALUES  
(N'Banco do Brazel'),  
(N'Santo Andre  Bank');  
INSERT INTO Bank.dbo.BankTrader (TraderSector,TraderName,BankID) VALUES  
(1,N'iFood',0),  
(1,N'Uber',0),  
(1,N'TikTok',0),  
(0,N'ONU',0),  
(0,N'FMI',0),  
(0,N'US-GOV',0);  
INSERT INTO Bank.dbo.TraderCategoryRule (TraderCategoryRuleName,TraderCategoryRuleLessGreater,TraderCategoryRuleValue,TraderCategoryRuleValue\_,TraderCategoryRuleDescription,TraderCategoryRuleSector) VALUES  
(N'LOWRISK',0,1000000.0000,1000000,N'Trades with value less than 1,000,000 and client from Public Sector',0),  
(N'MEDIUMRISK',1,1000000.0000,1000000,N'Trades with value greater than 1,000,000 and client from Public Sector',0),  
(N'HIGHRISK',1,1000000.0000,1000000,N'Trades with value greater than 1,000,000 and client from Private Sector',1),  
(N'LOWRISK P',0,1000000.0000,1000000,N'Trades with value less than 1,000,000 and client from Private Sector',1);  
INSERT INTO Bank.dbo.TraderTransaction (TransactionName,TraderID,TransactionValue,TransactionValue\_) VALUES  
(N'Investment',0,10000,10000.0000),  
(N'Loan',1,50000,50000.0000),  
(N'Loan',2,400000,400000.0000),  
(N'Investment',3,500000,500000.0000),  
(N'Loan',0,2000000,2000000.0000),  
(N'Loan',4,1000000,1000000.0000),  
(N'Investment',5,400000,400000.0000),  
(N'Loan',4,3000000,3000000.0000);
```

### Step 2: The Entity Framework reverse engineering databsase auto gererating code

#### Step 2.1: Install necesssary tools

```
sudo apt install dotnet-sdk-6.0
```

```
dotnet tool install --global dotnet-ef
```

```
dotnet tool update --global dotnet-ef
```

#### Step 2.2: Create new project based on the DotNet 'Console' template tool

```
dotnet new console -o BankTraders
```

Go to the project folder

```
cd BankTraders
```

Add the dependencies

```
dotnet add package Microsoft.EntityFrameworkCore.Design
```

```
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
```

Verify all componentes

```
dotnet ef
```

![](https://user-images.githubusercontent.com/9384127/176754312-fdb624ee-ac13-4fba-ac87-a1afc3673f04.png)  
.

#### Step 2.3: Generate all the reverse engineering code based on the database and save it on the Model folder

```
dotnet ef dbcontext scaffold "Data Source=localhost; Initial Catalog=Bank; User Id=sa; Password=PassWord232#"  Microsoft.EntityFrameworkCore.SqlServer -o Model
```

![](https://user-images.githubusercontent.com/9384127/176758898-257c5756-e907-4504-af6b-138c3557904b.png)  
![](https://user-images.githubusercontent.com/9384127/176759153-41a434af-5a0e-42d9-bd16-bf5c85b302d6.png)  
![](https://camo.githubusercontent.com/e50420181f6dfab76961e02a8510ddbf72d366d2bcad0808c5e9f2b32deb18ff/68747470733a2f2f6c68352e676f6f676c6575736572636f6e74656e742e636f6d2f4c5179634f74617a7675454465426e7a5a6372494c6a5045574a792d7436594b35316f505f476247635453384c68544842785f5f6d6a2d56765062453941434f3952486f5853505746566c34776e6152634d474c71345071693973644330556b4e5879597777773855584e654a6a4876746965784f4b6871543278504f53756a51706d32596e642d7a7833375758784b5667)

---

.
