INSERT INTO Bank.dbo.Bank (BankName) VALUES
	 (N'Banco do Brazel'),
	 (N'Santo Andre  Bank');
INSERT INTO Bank.dbo.BankTrader (TraderSector,TraderName,BankID) VALUES
	 (1,N'iFood',0),
	 (1,N'Uber',0),
	 (1,N'TikTok',0),
	 (0,N'ONU',0),
	 (0,N'FMI',0),
	 (0,N'US-GOV',0);
INSERT INTO Bank.dbo.TraderCategoryRule (TraderCategoryRuleName,TraderCategoryRuleLessGreater,TraderCategoryRuleValue,TraderCategoryRuleValue_,TraderCategoryRuleDescription,TraderCategoryRuleSector) VALUES
	 (N'LOWRISK',0,1000000.0000,1000000,N'Trades with value less than 1,000,000 and client from Public Sector',0),
	 (N'MEDIUMRISK',1,1000000.0000,1000000,N'Trades with value greater than 1,000,000 and client from Public Sector',0),
	 (N'HIGHRISK',1,1000000.0000,1000000,N'Trades with value greater than 1,000,000 and client from Private Sector',1),
	 (N'LOWRISK P',0,1000000.0000,1000000,N'Trades with value less than 1,000,000 and client from Private Sector',1);
INSERT INTO Bank.dbo.TraderTransaction (TransactionName,TraderID,TransactionValue,TransactionValue_) VALUES
	 (N'Investment',0,10000,10000.0000),
	 (N'Loan',1,50000,50000.0000),
	 (N'Loan',2,400000,400000.0000),
	 (N'Investment',3,500000,500000.0000),
	 (N'Loan',0,2000000,2000000.0000),
	 (N'Loan',4,1000000,1000000.0000),
	 (N'Investment',5,400000,400000.0000),
	 (N'Loan',4,3000000,3000000.0000);
