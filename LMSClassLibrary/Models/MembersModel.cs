using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models
{
    public class MembersModel
    {
        public int MemberId { get; set; }
        public string MemberName { get; set; }
        public string Email { get; set; }
        public DateTime DOB { get; set; }
        public string Contact { get; set; }
        public int DepartmentId { get; set; }
        public int MemberTypeId { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public List<MembersModel> MembersList { get; set; }
    }
}
