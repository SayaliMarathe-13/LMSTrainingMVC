using System;

namespace DAL.Models
{
    public class BookIssueDocumentsModel
    {
        public int DocumentId { get; set; }
        public int BookIssueId { get; set; }
        public string FileName { get; set; }
        public string FilePath { get; set; }
        public string ContentType { get; set; }
        public bool IsActive { get; set; } = true;
        public int UploadedBy { get; set; }
        public DateTime UploadedOn { get; set; } = DateTime.Now;
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
    }
}
