using System;
using System.Collections.Generic;

namespace BankTraders.Model
{
    public partial class Bank
    {
        public Bank()
        {
            BankTraders = new HashSet<BankTrader>();
        }

        public int BankId { get; set; }
        public string BankName { get; set; } = null!;

        public virtual ICollection<BankTrader> BankTraders { get; set; }
    }
}
