using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DAL.Models
{
    public class BooksModel
    {
        public int BookId { get; set; }

        [Required(ErrorMessage = "Book Name is required.")]
        [StringLength(100, ErrorMessage = "Book Name cannot exceed 100 characters.")]
        public string BookName { get; set; }

        [Required(ErrorMessage = "ISBN is required.")]
        [RegularExpression(@"^\d{10}$", ErrorMessage = "ISBN must contain exactly 10 digits.")]
        public string ISBN { get; set; }

        [Required(ErrorMessage = "Total Copies is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Total Copies must be a positive number.")]
        public int TotalCopies { get; set; }

        [Required(ErrorMessage = "Publisher is required.")]
        public int PublisherId { get; set; }
        public string PublisherName { get; set; }

        [Required(ErrorMessage = "Course is required.")]
        public int CourseId { get; set; }
        public string CourseName { get; set; }

        [Required(ErrorMessage = "Supplier is required.")]
        public int SupplierId { get; set; }
        public string SupplierName { get; set; }

        [Required(ErrorMessage = "IsActive is required.")]
        public bool IsActive { get; set; } = false;

        public int? CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }

        public List<BooksModel> BooksList { get; set; }
        public List<PublishersModel> PublishersList { get; set; }
        public List<SuppliersModel> SuppliersList { get; set; }
        public List<CoursesModel> CoursesList { get; set; }
        public List<int> CourseIds { get; set; }=new List<int>();
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 10;
        public int TotalRecords { get; set; }
    }
}
