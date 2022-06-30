using System;
using System.Collections.Generic;

namespace BankTraders.Model
{
    public partial class BankTrader
    {
        public BankTrader()
        {
            TraderTransactions = new HashSet<TraderTransaction>();
        }

        public int TraderId { get; set; }
        /// <summary>
        /// 0 Public | 1 Private
        /// </summary>
        public short TraderSector { get; set; }
        public string TraderName { get; set; } = null!;
        public int? BankId { get; set; }

        public virtual Bank? Bank { get; set; }
        public virtual ICollection<TraderTransaction> TraderTransactions { get; set; }
    }
}
