using System;
using System.Collections.Generic;

namespace BankTraders.Model
{
    public partial class Vwrisk
    {
        public string TraderName { get; set; } = null!;
        public string TraderSector { get; set; } = null!;
        public string? Risk { get; set; }
        public decimal? TransactionValue { get; set; }
    }
}
