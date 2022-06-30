using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace BankTraders.Model
{
    public partial class BankContext : DbContext
    {
        public BankContext()
        {
        }

        public BankContext(DbContextOptions<BankContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Bank> Banks { get; set; } = null!;
        public virtual DbSet<BankTrader> BankTraders { get; set; } = null!;
        public virtual DbSet<TraderCategory> TraderCategories { get; set; } = null!;
        public virtual DbSet<TraderCategoryRule> TraderCategoryRules { get; set; } = null!;
        public virtual DbSet<TraderTransaction> TraderTransactions { get; set; } = null!;
        public virtual DbSet<Vwrisk> Vwrisks { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=localhost; Initial Catalog=Bank; User Id=sa; Password=Higor232#");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Bank>(entity =>
            {
                entity.ToTable("Bank");

                entity.HasIndex(e => e.BankName, "Bank_UN")
                    .IsUnique();

                entity.HasIndex(e => e.BankId, "Banks_BankID_IDX")
                    .IsUnique();

                entity.Property(e => e.BankId).HasColumnName("BankID");

                entity.Property(e => e.BankName)
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<BankTrader>(entity =>
            {
                entity.HasKey(e => e.TraderId)
                    .HasName("BankTrader_PK");

                entity.ToTable("BankTrader");

                entity.Property(e => e.TraderId).HasColumnName("TraderID");

                entity.Property(e => e.BankId).HasColumnName("BankID");

                entity.Property(e => e.TraderName)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.TraderSector).HasComment("0 Public | 1 Private");

                entity.HasOne(d => d.Bank)
                    .WithMany(p => p.BankTraders)
                    .HasForeignKey(d => d.BankId)
                    .HasConstraintName("BankTrader_FK");
            });

            modelBuilder.Entity<TraderCategory>(entity =>
            {
                entity.ToTable("TraderCategory");

                entity.HasIndex(e => e.TraderCategoryName, "TraderCategory_UN")
                    .IsUnique();

                entity.Property(e => e.TraderCategoryId).HasColumnName("TraderCategoryID");

                entity.Property(e => e.TraderCategoryName)
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TraderCategoryRule>(entity =>
            {
                entity.ToTable("TraderCategoryRule");

                entity.HasIndex(e => new { e.TraderCategoryRuleLessGreater, e.TraderCategoryRuleValue, e.TraderCategoryRuleValue1, e.TraderCategoryRuleSector }, "TraderCategoryRule_TraderCategoryRuleLessGreater_IDX");

                entity.HasIndex(e => e.TraderCategoryRuleSector, "TraderCategoryRule_TraderCategoryRuleSector_IDX");

                entity.HasIndex(e => e.TraderCategoryRuleValue, "TraderCategoryRule_TraderCategoryRuleValue_IDX");

                entity.HasIndex(e => e.TraderCategoryRuleValue1, "TraderCategoryRule_TraderCategoryRuleValue__IDX");

                entity.HasIndex(e => e.TraderCategoryRuleName, "TraderCategoryRule_UN")
                    .IsUnique();

                entity.Property(e => e.TraderCategoryRuleId).HasColumnName("TraderCategoryRuleID");

                entity.Property(e => e.TraderCategoryRuleDescription)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.TraderCategoryRuleLessGreater).HasComment("0 values LESS than  | 1 values GREATEER than");

                entity.Property(e => e.TraderCategoryRuleName)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.TraderCategoryRuleSector).HasComment("0 Public | 1 Private");

                entity.Property(e => e.TraderCategoryRuleValue).HasColumnType("money");

                entity.Property(e => e.TraderCategoryRuleValue1)
                    .HasColumnType("decimal(38, 0)")
                    .HasColumnName("TraderCategoryRuleValue_");
            });

            modelBuilder.Entity<TraderTransaction>(entity =>
            {
                entity.HasKey(e => e.TransactionId)
                    .HasName("TraderTransaction_PK");

                entity.ToTable("TraderTransaction");

                entity.HasIndex(e => e.TraderId, "TraderTransaction_TraderID_IDX");

                entity.HasIndex(e => new { e.TransactionValue, e.TransactionValue1 }, "TraderTransaction_TransactionValue_IDX");

                entity.HasIndex(e => e.TransactionValue1, "TraderTransaction_TransactionValue__IDX");

                entity.Property(e => e.TransactionId).HasColumnName("TransactionID");

                entity.Property(e => e.TraderId).HasColumnName("TraderID");

                entity.Property(e => e.TransactionName)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.TransactionValue).HasColumnType("decimal(38, 0)");

                entity.Property(e => e.TransactionValue1)
                    .HasColumnType("money")
                    .HasColumnName("TransactionValue_");

                entity.HasOne(d => d.Trader)
                    .WithMany(p => p.TraderTransactions)
                    .HasForeignKey(d => d.TraderId)
                    .HasConstraintName("TraderTransaction_FK");
            });

            modelBuilder.Entity<Vwrisk>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("VWRISKS");

                entity.Property(e => e.Risk)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.TraderName)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.TraderSector)
                    .HasMaxLength(7)
                    .IsUnicode(false);

                entity.Property(e => e.TransactionValue).HasColumnType("decimal(38, 0)");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
