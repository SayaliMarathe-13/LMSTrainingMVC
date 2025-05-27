using DAL.Dal;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Practices.EnterpriseLibrary.Data;
using LMSClassLibrary.Models;

namespace DAL.Models
{
    public class BookIssueModel
    {
        
        public int BookIssueId { get; set; }
        public int MemberId { get; set; }
        public DateTime? IssueDate { get; set; }
        public DateTime? DueDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public int LibrarianId { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
  
        public List<MembersModel> MembersList { get; set; }
        public List<BookIssueDetailsModel> SelectedBooks { get; set; }
        //public List<BookSelectionModel> SelectedBooks { get; set; }



    }
    public class BookSelectionModel
    {
        public int BookId { get; set; }
        public int Quantity { get; set; }
    }
}
