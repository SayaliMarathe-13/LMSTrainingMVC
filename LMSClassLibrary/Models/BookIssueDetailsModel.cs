using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMSClassLibrary.Models
{
    public class BookIssueDetailsModel
    {
        public int BookIssueDetailId { get; set; }
        public int BookIssueId { get; set; }
        public int BookId { get; set; }
        public string BookName { get; set; }
        public string ISBN { get; set; }
        public string PublisherName { get; set; }
        public string CourseName { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public int Quantity { get; set; }

        public bool IsNew { get; set; }

    }
}
