# coding: utf-8
from sqlalchemy import Column, ForeignKey, Index, Integer, Numeric, SmallInteger, String, Table, text
from sqlalchemy.dialects.mssql.base import MONEY
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()
metadata = Base.metadata


class Bank(Base):
    __tablename__ = 'Bank'

    BankID = Column(Integer, primary_key=True, unique=True)
    BankName = Column(String(100, 'SQL_Latin1_General_CP1_CI_AS'), nullable=False, unique=True)


class BankTrader(Base):
    __tablename__ = 'BankTrader'

    TraderID = Column(Integer, primary_key=True)
    TraderSector = Column(SmallInteger, nullable=False, server_default=text("((0))"))
    TraderName = Column(String(100, 'SQL_Latin1_General_CP1_CI_AS'), nullable=False)
    BankID = Column(Integer)


class TraderCategory(Base):
    __tablename__ = 'TraderCategory'

    TraderCategoryID = Column(Integer, primary_key=True)
    TraderCategoryName = Column(String(100, 'SQL_Latin1_General_CP1_CI_AS'), nullable=False, unique=True)


class TraderCategoryRule(Base):
    __tablename__ = 'TraderCategoryRule'
    __table_args__ = (
        Index('TraderCategoryRule_TraderCategoryRuleLessGreater_IDX', 'TraderCategoryRuleLessGreater', 'TraderCategoryRuleValue', 'TraderCategoryRuleValue_', 'TraderCategoryRuleSector'),
    )

    TraderCategoryRuleID = Column(Integer, primary_key=True)
    TraderCategoryRuleName = Column(String(100, 'SQL_Latin1_General_CP1_CI_AS'), nullable=False, unique=True)
    TraderCategoryRuleLessGreater = Column(SmallInteger, nullable=False, server_default=text("((0))"))
    TraderCategoryRuleValue = Column(MONEY, nullable=False, index=True)
    TraderCategoryRuleValue_ = Column(Numeric(38, 0), index=True)
    TraderCategoryRuleDescription = Column(String(100, 'SQL_Latin1_General_CP1_CI_AS'))
    TraderCategoryRuleSector = Column(Integer, nullable=False, index=True, server_default=text("((0))"))


class TraderTransaction(Base):
    __tablename__ = 'TraderTransaction'
    __table_args__ = (
        Index('TraderTransaction_TransactionValue_IDX', 'TransactionValue', 'TransactionValue_'),
    )

    TransactionID = Column(Integer, primary_key=True)
    TransactionName = Column(String(100, 'SQL_Latin1_General_CP1_CI_AS'), nullable=False)
    TraderID = Column(ForeignKey('BankTrader.TraderID'), index=True)
    TransactionValue = Column(Numeric(38, 0))
    TransactionValue_ = Column(MONEY, index=True)

    BankTrader = relationship('BankTrader')


t_VWRISKS = Table(
    'VWRISKS', metadata,
    Column('TraderName', String(100, 'SQL_Latin1_General_CP1_CI_AS'), nullable=False),
    Column('TraderSector', String(7, 'SQL_Latin1_General_CP1_CI_AS'), nullable=False),
    Column('Risk', String(100, 'SQL_Latin1_General_CP1_CI_AS')),
    Column('TransactionValue', Numeric(38, 0))
)
