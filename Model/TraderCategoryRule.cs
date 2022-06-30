using System;
using System.Collections.Generic;

namespace BankTraders.Model
{
    public partial class TraderCategoryRule
    {
        public int TraderCategoryRuleId { get; set; }
        public string TraderCategoryRuleName { get; set; } = null!;
        /// <summary>
        /// 0 values LESS than  | 1 values GREATEER than
        /// </summary>
        public short TraderCategoryRuleLessGreater { get; set; }
        public decimal TraderCategoryRuleValue { get; set; }
        public decimal? TraderCategoryRuleValue1 { get; set; }
        public string? TraderCategoryRuleDescription { get; set; }
        /// <summary>
        /// 0 Public | 1 Private
        /// </summary>
        public int TraderCategoryRuleSector { get; set; }
    }
}
