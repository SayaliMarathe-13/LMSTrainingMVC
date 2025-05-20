using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMSClassLibrary.Models
{
    public class BookIssueDetailsModel
    {
        public int BookIssueDetailsId { get; set; }
        public int BookIssueId { get; set; }
        public int BookId { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
    }
}
