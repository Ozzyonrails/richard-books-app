class Book
  attr_accessor :id, :title, :author, :year

  def initialize(id: nil, title: nil, author: nil, year: nil)
    @id = id
    @title = title
    @author = author
    @year = year
  end

  def show
    "ID: #{id}, Title: #{title}, Author: #{author}, Year: #{year}"
  end

  def validate
    raise 'Invalid input' if [title, author, year].any? { |argument| argument.nil? || argument == '' }
  end
end


class BookApplication
  attr_accessor :books

  def initialize
    @books = {}
  end

  def create(title:, author:, year:)
    book = Book.new(id: assign_next_id, title: title, author: author, year: year)
    book.validate
    books[book.id] = book
    book
  end

  def list_all_books
    books.values
  end

  def find(id = nil)
    return 'No ID provided' if id.nil?

    book = books[id]
    book.nil? ? "No book was found with ID #{id}" : book
  end

  def update(id:, title:, author:, year:)
    book = books[id]
    return "No book was found with ID #{id}" if book.nil?

    book.title = title
    book.author = author
    book.year = year
    book.validate
    books[id] = book
    book
  end

  def delete(id:)
    book = books.delete(id)
    return false if book.nil?

    true
  end

  private

  def assign_next_id
    books.empty? ? 1 : books.keys.last + 1
  end
end
