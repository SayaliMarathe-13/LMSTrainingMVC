using System.Web.Mvc;
using DAL.Models;
using DAL.Dal;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Web;
using System.Configuration;
using System.IO;
using Newtonsoft.Json;


namespace WebApplication2.Controllers
{
    public class BooksController : Controller
    {
        Handler handler = new Handler();

        public ActionResult List()
        {
            try
            {
                
                //throw new Exception("manual test exception for logging");
                BooksModel model = Session["SearchFormData"] as BooksModel ?? new BooksModel();
                Publishers publishersDal = new Publishers();
                Suppliers suppliersDal = new Suppliers();
                Courses coursesDal = new Courses();
                model.IsSelectionMode = Session["IsSelectionMode"] as bool? ?? false;
                model.PublishersList = publishersDal.GetAllPublisherNames();
                model.SuppliersList = suppliersDal.GetAllSupplierNames();
                model.CoursesList = coursesDal.GetAllCourseNames();

                return View(model);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                ViewBag.ErrorMessage = "An error occurred: " + ex.Message;
                return View("Error");

            }
        }

        public ActionResult GetBooksList(BooksModel model)
        {
            try
            {
                model.IsSelectionMode = Session["IsSelectionMode"] as bool? ?? false;

                Session["SearchFormData"] = model;
                Books booksDal = new Books();
                model.BooksList = booksDal.GetSearchedBooksList(model);

                return PartialView("_BooksTable", model);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                return Json(new { success = false, message = "Something Error Occurred..." });
            }
        }

        //ADD OR EDIT
        public ActionResult AddBook(int? id)
        {
            try
            {
                var model = new BooksModel();

                if (id.HasValue && id.Value > 0)
                {
                    var book = new Books { BookId = id.Value };

                    if (!book.Load())
                    {
                        return HttpNotFound("Book not found");
                    }

                    model.BookId = book.BookId;
                    model.BookName = book.BookName;
                    model.ISBN = book.ISBN;
                    model.TotalCopies = book.TotalCopies;
                    model.PublisherId = book.PublisherId;
                    model.CourseId = book.CourseId;
                    model.SupplierId = book.SupplierId;
                    model.IsActive = book.IsActive;
                }

                var publishersDal = new Publishers();
                var suppliersDal = new Suppliers();
                var coursesDal = new Courses();
                model.PublishersList = publishersDal.GetAllPublisherNames();
                model.SuppliersList = suppliersDal.GetAllSupplierNames();
                model.CoursesList = coursesDal.GetAllCourseNames();

                return View("_AddBook", model);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                ViewBag.ErrorMessage = "An error occurred: " + ex.Message;
                return View("Error");
            }
        }

        //ADD OR EDIT (POST)
        [HttpPost]
        public JsonResult AddBook(BooksModel model)
        {
            try
            {
                //throw new Exception("manual test exception for logging");
                if (!ModelState.IsValid)
                {
                    var errors = ModelState
                                    .Where(x => x.Value.Errors.Count > 0)
                                    .ToDictionary(
                                        x => x.Key,
                                        x => x.Value.Errors.Select(e => e.ErrorMessage).ToList()
                                    );
                    return Json(new { success = false, errors });
                }

                Books book = new Books
                {
                    BookId = model.BookId,
                    BookName = model.BookName,
                    PublisherId = model.PublisherId,
                    ISBN = model.ISBN,
                    TotalCopies = model.TotalCopies,
                    CourseId = model.CourseId,
                    SupplierId = model.SupplierId,
                    IsActive = model.IsActive,
                    CreatedBy = 1,
                    CreatedOn = model.BookId == 0 ? DateTime.Now : model.CreatedOn,
                    ModifiedBy = model.BookId > 0 ? 1 : (int?)null,
                    ModifiedOn = model.BookId == 0 ? (DateTime?)null : DateTime.Now
                };

                if (book.Save())
                {
                    return Json(new { success = true, message = model.BookId == 0 ? "Book added successfully!" : "Book updated successfully!" });
                }

                return Json(new { success = false, message = model.BookId == 0 ? "Failed to save the book." : "Failed to Update the book." });
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                return Json(new { success = false, message = "Something Error Occurred..." });
            }
        }

        [HttpPost]
        public JsonResult DeleteBook(int Id)
        {
            try
            {
                Books book = new Books
                {
                    BookId = Id,
                    ModifiedBy = 1,
                    ModifiedOn = DateTime.Now
                };

                bool isDeleted = book.Delete();

                if (isDeleted)
                {
                    return Json(new { success = true, message = "Book deleted successfully." });
                }
                else
                {
                    return Json(new { success = true, message = "Failed to delete the book." });
                }
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                return Json(new { success = false, message = "An error occurred: " + ex.Message });
            }
        }

        public ActionResult IssueBooks(int? id)
        {
            try
            {
                var model = new BookIssueModel();
                var membersDal = new Members();
                model.MembersList = membersDal.GetAllMemberNames();

                if (id.HasValue && id.Value > 0)
                {
                    var issue = new BookIssue { BookIssueId = id.Value };
                    var bookIssueDetails = new BookIssueDetails { BookIssueId = id.Value };
                    model.IssuedBooks = bookIssueDetails.GetIssuedBooksByIssueId();

                    if (!issue.Load())
                    {
                        return HttpNotFound("Book issue not found");
                    }

                    // Map entity to model
                    model.BookIssueId = issue.BookIssueId;
                    model.MemberId = issue.MemberId;
                    model.IssueDate = issue.IssueDate;
                    model.DueDate = issue.DueDate;
                    model.ReturnDate = issue.ReturnDate;
                    model.LibrarianId = issue.LibrarianId;
                    model.IsActive = issue.IsActive;

                    //ViewBag.PageMode = "Edit";
                }
                else
                {
                    // Default values for new issue
                    model.LibrarianId = 1;
                    model.IssueDate = DateTime.Today;
                    model.DueDate = DateTime.Today.AddDays(7);
                    model.IsActive = true;

                    ViewBag.PageMode = "Add";
                }

                return View(model);

            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                ViewBag.ErrorMessage = "An error occurred: " + ex.Message;
                return View("Error");
            }
        }

        [HttpPost]
        public ActionResult IssueBooks(string model, IEnumerable<HttpPostedFileBase> SupportDocuments)
        {
            try
            {
                var bookIssueModel = JsonConvert.DeserializeObject<BookIssueModel>(model);

                if (bookIssueModel.SelectedBooks == null || !bookIssueModel.SelectedBooks.Any())
                {
                    return Json(new { success = false, message = "Please select at least one book." });
                }
                bool isNew = bookIssueModel.BookIssueId == 0;
                bookIssueModel.CreatedBy = bookIssueModel.BookIssueId == 0 ? 1 : bookIssueModel.CreatedBy;
                bookIssueModel.ModifiedBy = bookIssueModel.BookIssueId > 0 ? 1 : (int?)null;

                BookIssue dal = new BookIssue();
                bool saved = dal.SaveOrUpdate(bookIssueModel);

                if (saved && bookIssueModel.BookIssueId > 0 && SupportDocuments != null)
                {
                    foreach (var file in SupportDocuments)
                    {
                        if (file != null && file.ContentLength > 0)
                        {
                            var uploadDirPath = ConfigurationManager.AppSettings["UploadFolder"]; 
                            var uploadDir = Server.MapPath(uploadDirPath);
                            Directory.CreateDirectory(uploadDir);

                            var fileExtension = Path.GetExtension(file.FileName);
                            var uniqueFileName = $"{Guid.NewGuid()}{fileExtension}";
                            var fullPath = Path.Combine(uploadDir, uniqueFileName);

                            file.SaveAs(fullPath);

                            var doc = new BookIssueDocuments
                            {
                                BookIssueId = bookIssueModel.BookIssueId,
                                FileName = file.FileName,
                                FilePath = uniqueFileName, 
                                ContentType = file.ContentType,
                                UploadedBy = bookIssueModel.CreatedBy,
                            };

                            BookIssueDocuments bookIssueDocuments = new BookIssueDocuments();
                            bookIssueDocuments.Insert(doc);
                        }

                    }
                }
                if (bookIssueModel.DeletedDocumentIds != null && bookIssueModel.DeletedDocumentIds.Any())
                {
                    BookIssueDocuments bookIssueDocuments = new BookIssueDocuments();
                    foreach (var docId in bookIssueModel.DeletedDocumentIds)
                    {
                        bookIssueDocuments.Delete(docId);
                    }
                }

                if (!saved)
                    return Json(new { success = false, message = "Failed to save book issue." });

                    string message = isNew
                 ? "Book issue created successfully."
                 : "Book issue updated successfully.";


                return Json(new { success = true, message });
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                return Json(new { success = false, message = "Error occurred while issuing books." });
            }
        }


        public ActionResult IssueBooksList()
        {
            try
            {
                BookIssue bookIssueDal = new BookIssue();

                var model = new BookIssueModel();               
                Session["SearchFormData"] = model;              
                return View(model);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                ViewBag.ErrorMessage = "An error occurred: " + ex.Message;
                return View("Error");
            }
        }

        public ActionResult GetIssueBooksList(BookIssueModel model)
        {
            try
            {
                //Session["SearchFormData"] = model;
                BookIssue bookIssueDal = new BookIssue();
                model.IssueBookList = bookIssueDal.GetBookIssueList(model);
                return PartialView("_IssueBooksTable", model);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                return Json(new { success = false, message = "Something went wrong. Please try again." }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpGet]
        public JsonResult GetAvailableCopies(int bookId)
        {
            try
            {
                Books dal = new Books(); 
                int availableCopies = dal.GetTotalCopiesByBookId(bookId);

                return Json(new { success = true, availableCopies = availableCopies }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                return Json(new { success = false, message = "Error fetching available copies." }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpPost]
        public ActionResult SetSelectionMode(bool isSelectionMode)
        {
            Session["IsSelectionMode"] = isSelectionMode;
            return Json(new { success = true });
        }
        [HttpGet]
        public JsonResult GetDocuments(int bookIssueId)
        {
            try
            {
                var dal = new BookIssueDocuments();
                var docs = dal.GetDocumentsByBookIssueId(bookIssueId);

                var result = docs.Select(d => new
                {
                    d.DocumentId,
                    d.FileName,
                    d.FilePath
                });

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                return Json(new { success = false, message = "Failed to load documents." }, JsonRequestBehavior.AllowGet);
            }
        }
        
        public ActionResult DownloadDocument(int documentId)
        {
            BookIssueDocuments bookIssueDocuments = new BookIssueDocuments();
            var document = bookIssueDocuments.GetDocumentById(documentId);

            if (document == null)
                return HttpNotFound();

            var uploadDirPath = ConfigurationManager.AppSettings["UploadFolder"]; // "~/UploadedDocuments"
            var fullVirtualPath = Path.Combine(uploadDirPath, document.FilePath).Replace("\\", "/");
            var filePath = Server.MapPath(fullVirtualPath);

            if (!System.IO.File.Exists(filePath))
                return HttpNotFound();

            return File(filePath, document.ContentType, document.FileName);
        }

    }

}

