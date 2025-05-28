using System;
using System.Collections.Generic;

namespace DAL.Models
{
    public class LibrariansModel
    {
        public int LibrarianId { get; set; }
        public string LibrarianName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }

        public List<LibrariansModel> LibrariansList { get; set; }
    }
}
