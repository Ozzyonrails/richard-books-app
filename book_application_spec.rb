require_relative 'spec_helper'

RSpec.describe BookApplication do
  let(:app) { BookApplication.new }

  describe '#create' do
    context 'when creating a new book' do
      it 'adds a book return the created book' do
        expect(app.books.count).to eq(0)
        book = app.create(title: "title1", author: 'Author1', year: '2001')

        expect(app.books.count).to eq(1)
        expect(book).to be_a(Book)
        expect(book.title).to eq('title1')
        expect(book.author).to eq('Author1')
        expect(book.year).to eq('2001')
      end
    end

    context 'when there are some books present already' do
      before { app.create(title: "title1", author: 'Author1', year: '2001') }

      it 'assigns the correct ID' do
        book = app.create(title: "title2", author: 'Author2', year: '2002')

        expect(app.books.keys.last).to eq(2)
        expect(book.id).to eq(2)
        expect(book.title).to eq('title2')
      end
    end
  end

  describe '#list_all_books' do
    context 'when there are no books' do
      it 'returns an empty array' do
        books = app.list_all_books

        expect(books).to be_an(Array)
        expect(books).to be_empty
      end
    end

    context 'when there are some books present' do
      before do
        app.create(title: "title1", author: 'Author1', year: '2001')
        app.create(title: "title2", author: 'Author2', year: '2002')
      end

      it 'returns an array of all books' do
        books = app.list_all_books

        expect(books).to be_an(Array)
        expect(books.size).to eq(2)
        expect(books.first).to be_a(Book)
        expect(books.first.title).to eq('title1')
      end
    end
  end

  describe '#find' do
    before { app.create(title: "title1", author: 'Author1', year: '2001') }

    context 'when the book ID exists' do
      it 'returns the correct book' do
        book = app.find(1)

        expect(book).to be_a(Book)
        expect(book.id).to eq(1)
        expect(book.title).to eq('title1')
      end
    end

    context 'when the book ID does not exist' do
      it 'returns an error message' do
        result = app.find(5)

        expect(result).to eq("No book was found with ID 5")
      end
    end

    context 'when no ID was provided' do
      it 'returns an error message for missing ID' do
        result = app.find

        expect(result).to eq('No ID provided')
      end
    end
  end

  describe '#update' do
    before { app.create(title: "title1", author: 'Author1', year: '2001') }

    context 'when the book exists' do
      it 'updates the book details and returns the updated book' do
        updated_book = app.update(id: 1, title: "Updated Title", author: "Updated Author", year: "2022")

        expect(updated_book).to be_a(Book)
        expect(updated_book.title).to eq("Updated Title")
        expect(updated_book.author).to eq("Updated Author")
        expect(updated_book.year).to eq("2022")
      end
    end

    context 'when the book not exists' do
      it 'returns an error message' do
        result = app.update(id: 5, title: "New Title", author: "New Author", year: "2022")

        expect(result).to eq("No book was found with ID 5")
      end
    end
  end

  describe '#delete' do
    before do
      app.create(title: "title1", author: 'Author1', year: '2001')
      app.create(title: "title2", author: 'Author2', year: '2002')
    end

    context 'when the book exists' do
      it 'deletes the book and returns the deleted book' do
        expect(app.books.count).to eq(2)
        expect(app.delete(id: 1)).to be_truthy
        expect(app.books.keys).not_to include(1)
      end
    end

    context 'when the book not exists' do
      it 'returns an error message' do
        expect(app.delete(id: 5)).to be_falsey
      end
    end
  end
end
