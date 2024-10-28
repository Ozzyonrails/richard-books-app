require_relative 'spec_helper'
RSpec.describe BookApplication do

  describe '#create' do
    let!(:app) { BookApplication.new}

    context 'when there are no books in storage' do
      it 'creates the book' do
        puts 'Example started'
        app.create(title: "title1", author: 'Author1', year: '2001')

        expect(app.books.count).to eq(1)
        book = app.books[1]
        expect(book.title).to eq('title1')
        expect(book.author).to eq('Author1')
        expect(book.year).to eq('2001')
      end
    end

    context 'when there are some books present' do
      before do
        app.create(title: "title1", author: 'Author1', year: '2001')
      end

      it 'assigns the next id to the book' do
        app.create(title: "title2", author: 'Author2', year: '2002')
        books = app.books
        expect(books.keys.last).to eq(2)
      end
    end
  end

  describe '#list_all_books' do
    let!(:app) { BookApplication.new}

    before
  end

end

