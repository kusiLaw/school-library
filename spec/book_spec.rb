require_relative '../book'
require_relative '../classroom'
require_relative '../teacher'
require_relative '../student'
require_relative '../rentals'

describe Book do
  title = 'Introduction to Ruby'
  author = 'Praises Tula'
  context 'Book could be created:' do
    it 'Created book created should be an instance of Book' do
      book = Book.new(title, author)
      expect(book).to be_an_instance_of Book
    end
  end

  context 'When title and author are used to create a book instance:' do
    book = Book.new(title, author)
    it 'Book title should reflect title agument' do
      expect(book.title).to eq 'Introduction to Ruby'
    end

    it 'Book author should reflect author agument' do
      expect(book.author).to eq 'Praises Tula'
    end
  end

  context 'When rentals are made on a book:' do
    book = Book.new(title, author)
    classroom = Classroom.new('Frontend')
    student = Student.new(classroom, 20, 'Maximilianus', true)
    teacher = Teacher.new('Backend', 25, 'Zeus')
    it 'Rentals count should be zero(0) on initialization' do
      expect(book.rentals.length).to eq 0
    end

    it 'Addition of rentals should be possible' do
      Rentals.new('2022/09/07', book, student)
      expect(book.rentals.length).to eq 1
    end

    it 'Should permit addition multiple different rentals' do
      Rentals.new('2022/10/01', book, teacher)
      Rentals.new('2022/11/14', book, student)
      expect(book.rentals.length).to eq 3
    end
  end
end
