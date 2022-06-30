using System;
using System.Collections.Generic;

namespace BankTraders.Model
{
    public partial class TraderTransaction
    {
        public int TransactionId { get; set; }
        public string TransactionName { get; set; } = null!;
        public int? TraderId { get; set; }
        public decimal? TransactionValue { get; set; }
        public decimal? TransactionValue1 { get; set; }

        public virtual BankTrader? Trader { get; set; }
    }
}
