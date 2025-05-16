using System;
using System.Collections.Generic;
using DAL.Models;

namespace WebApplication2.Models
{
    public class BookViewModel
    {
        public int BookId { get; set; }
        public string BookName { get; set; }
        public string PublisherName { get; set; }
        public string ISBN { get; set; }
        public int TotalCopies { get; set; }
        public string CourseName { get; set; }
        public string SupplierName { get; set; }
        public bool? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
    }

    public class BooksViewModel
    {
        public List<BookViewModel> Books { get; set; }
        public List<PublishersModel> PublishersList { get; set; }
        public List<SuppliersModel> SuppliersList { get; set; }
        public List<CoursesModel> CoursesList { get; set; }
        
        public string SearchBookName { get; set; }
        public int SelectedPublisherId { get; set; }
        public int SelectedSupplierId { get; set; }
        public int SelectedCourseId { get; set; }

        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 10;

    }
}
