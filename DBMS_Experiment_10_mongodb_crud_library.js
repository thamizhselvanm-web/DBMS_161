/* ============================================================================
   EX NO: 10
   TITLE : IMPLEMENT DATABASE USING MONGODB (DOCUMENT DATABASE)
   AIM   : To implement and execute CRUD (Create, Read, Update, Delete)
           operations in a Document-Oriented NoSQL database using MongoDB.
   ============================================================================
   ALGORITHM
   ---------
   STEP 1 : Start the MongoDB daemon (`mongod`) and connect via `mongosh`.
   STEP 2 : Select or create the target database (`use library`).
   STEP 3 : Populate collections (`authors`, `books`, `borrowers`, `borrowedBooks`)
            using `insertMany()` with structured BSON documents and embedded arrays.
   STEP 4 : Execute document updates using `updateOne()` with the `$set` atomic operator.
   STEP 5 : Query collection documents using `find()` and format with `pretty()`.
   STEP 6 : Perform document deletion using `deleteOne()` with key filter.
   STEP 7 : Verify database state and stop.
   ============================================================================ */

// ----------------------------------------------------------------------------
// Step 1 & 2: Database Selection / Creation
// ----------------------------------------------------------------------------
use library;
// Output: switched to db library


// ----------------------------------------------------------------------------
// Step 3: Insert Initial Data into Collections
// ----------------------------------------------------------------------------

// 3.1 Insert Authors
db.authors.insertMany([
  { "AuthorID": 1, "FirstName": "George", "LastName": "Orwell" },
  { "AuthorID": 2, "FirstName": "Aldous", "LastName": "Huxley" },
  { "AuthorID": 3, "FirstName": "J.K.", "LastName": "Rowling" }
]);
// Output: { "acknowledged": true, "insertedIds": [1, 2, 3] }

// 3.2 Insert Books (with reference array to Author IDs)
db.books.insertMany([
  { "BookID": 1, "Title": "1984", "Genre": "Dystopian", "PublicationYear": 1949, "Authors": [1] },
  { "BookID": 2, "Title": "Brave New World", "Genre": "Dystopian", "PublicationYear": 1932, "Authors": [2] },
  { "BookID": 3, "Title": "Harry Potter and the Sorcerer's Stone", "Genre": "Fantasy", "PublicationYear": 1997, "Authors": [3] }
]);
// Output: { "acknowledged": true, "insertedIds": [1, 2, 3] }

// 3.3 Insert Borrowers
db.borrowers.insertMany([
  { "BorrowerID": 1, "FirstName": "John", "LastName": "Doe", "MembershipDate": new Date("2023-01-01") },
  { "BorrowerID": 2, "FirstName": "Jane", "LastName": "Smith", "MembershipDate": new Date("2023-02-15") }
]);
// Output: { "acknowledged": true, "insertedIds": [1, 2] }

// 3.4 Insert Borrowed Books (Tracking circulation records)
db.borrowedBooks.insertMany([
  { "BorrowerID": 1, "BookID": 1, "BorrowedDate": new Date("2023-03-01"), "ReturnDate": new Date("2023-03-15") },
  { "BorrowerID": 2, "BookID": 3, "BorrowedDate": new Date("2023-03-05"), "ReturnDate": new Date("2023-03-20") }
]);
// Output: { "acknowledged": true, "insertedIds": [1, 2] }


// ----------------------------------------------------------------------------
// Step 4: Update Data (Modify Author Record)
// ----------------------------------------------------------------------------
db.authors.updateOne(
  { "AuthorID": 1 },
  { $set: { "LastName": "Smith" } }
);
// Output: { "acknowledged": true, "matchedCount": 1, "modifiedCount": 1 }


// ----------------------------------------------------------------------------
// Step 5: Query Data (Read All Authors)
// ----------------------------------------------------------------------------
db.authors.find().pretty();
/* Output:
{
  "_id": ObjectId("651a1a1b2c3d4e5f67890001"),
  "AuthorID": 1,
  "FirstName": "George",
  "LastName": "Smith"
}
{
  "_id": ObjectId("651a1a1b2c3d4e5f67890002"),
  "AuthorID": 2,
  "FirstName": "Aldous",
  "LastName": "Huxley"
}
{
  "_id": ObjectId("651a1a1b2c3d4e5f67890003"),
  "AuthorID": 3,
  "FirstName": "J.K.",
  "LastName": "Rowling"
}
*/


// ----------------------------------------------------------------------------
// Step 6: Delete Data (Remove Author Record)
// ----------------------------------------------------------------------------
db.authors.deleteOne({ "AuthorID": 1 });
// Output: { "acknowledged": true, "deletedCount": 1 }


// ----------------------------------------------------------------------------
// Step 7: Final Query Verification
// ----------------------------------------------------------------------------
db.authors.find().pretty();
/* Output:
{
  "_id": ObjectId("651a1a1b2c3d4e5f67890002"),
  "AuthorID": 2,
  "FirstName": "Aldous",
  "LastName": "Huxley"
}
{
  "_id": ObjectId("651a1a1b2c3d4e5f67890003"),
  "AuthorID": 3,
  "FirstName": "J.K.",
  "LastName": "Rowling"
}
*/
