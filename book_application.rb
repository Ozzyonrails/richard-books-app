# 1.Create a new book with a title, author, and publication year.
#   2. Retrieve a list of all books.
#     3. Retrieve a specific book by its ID.
#       4. Update a book's information (title, author, publication year).
# 5. Delete a book by its ID.

# PLAN:
# 0. Implement storage
# 1. implement a ActiveRecord-like class to manage the books
#   1.1. Implement a creation of the book
#     - title
#     - author
#     - year
#   1.2. Get the list of books
#   1.3. Find by id
#   1.4. update attributes (assuming the id provided)
#   1.5. Delete by id
# 2. Error handling
# 3. Unit testing

Book = Struct.new(:author, :title, :year)
class BookApplication
  attr_accessor :books
  def initialize
    # books are going to be stored in hash where keys are id of the book (simple incrementation) and value - book itself
    @books = {}
  end

  def create(title:, author:, year:)
    validate_attributes(title: title, author: author, year: year)

    book = Book.new
    book.author = author
    book.title = title
    book.year = year
    books[assign_next_id] = book
  end

  def list_all_books
    puts "Here are all the books:"

    books.each do |id, book|
      show_book(id, book)
    end
  end

  def find(id = nil)
    return puts 'No ID provided' if id.nil?
    book = books[id]
    return puts "No book was found with id #{id}" if book.nil?
    # puts 'books:'
    # puts books
    show_book(id, book)
  end

  def update(id:, author:, title:, year:)
    book = books[id]
    return puts "No book was found with id #{id}" if book.nil?

    validate_attributes(title: title, author: author, year: year)

    book.author = author
    book.title = title
    book.year = year
    books[id] = book
    puts 'updated books'
    puts books
  end

  def delete(id:)
    book = books[id]
    return puts "No book was found with id #{id}" if book.nil?
    books.delete(id)
    puts 'updated books'
    puts books
  end


  private

  def validate_attributes(title:, author:, year:)
    raise 'Invalid input' if [title, author, year].any? { |argument| argument.nil? || argument == '' }
  end

  def assign_next_id
    books.keys.count > 0 ? books.keys.last + 1 : 1
  end

  def show_book(id, book)
    puts "id: #{id}"
    puts "title: #{book.title}"
    puts "author: #{book.author}"
    puts "year: #{book.year}"
    puts
  end


end

def script_run
  app = BookApplication.new
  app.create(title: "title1", author: 'Author1', year: '2001')
  app.create(title: "title2", author: 'Author2', year: '2002')
  app.list_all_books
  app.find(5)
  app.find
  app.find(2)
  app.update(id: 1, author: 'Changed author 1', title: 'Changed title 1' , year: 'Changed year 2002')
  app.delete(id: 2)
end

script_run



