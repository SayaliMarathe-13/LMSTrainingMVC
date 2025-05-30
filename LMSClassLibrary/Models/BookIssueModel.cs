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
        public string MemberName { get; set; }
        public DateTime? IssueDate { get; set; }
        public DateTime? DueDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public int LibrarianId { get; set; }
        public string LibrarianName { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public int BookIssueDetailId { get; set; }
        public List<MembersModel> MembersList { get; set; }
        public List<BookIssueDetailsModel> SelectedBooks { get; set; }
        public List<BookIssueModel> IssueBookList { get; set; }
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public int TotalRecords { get; set; }
        public List<BookIssueDetailsModel> IssuedBooks { get; set; }

        public List<BookIssueDetailsModel> ChangedBooks { get; set; } 

    }

}
