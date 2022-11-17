require_relative '../book'
require_relative '../classroom'
require_relative '../teacher'
require_relative '../student'
require_relative '../rentals'

describe Rentals do
  title = 'Advanced to Ruby'
  author = 'Lawrence Kusi'
  context 'Rentals could be created:' do
    it 'Rentals made on book should be an instance of Rentals' do
      rent = Rentals.new('2022/11/14', Book.new(title, author), Student.new('Frontend', 20))
      expect(rent).to be_an_instance_of Rentals
    end
  end

  context 'When date, book and person instance are used to create a rent instance:' do
    classroom = Classroom.new('Software Development')
    student = Student.new(classroom, 20)
    book = Book.new(title, author)
    rent = Rentals.new('2022/11/14', book, student)
    it 'Rent date should reflect date argument' do
      expect(rent.date).to eq '2022/11/14'
    end

    it 'Rent made should be reflected on student' do
      expect(student.rentals.length).to eq 1
    end

    it 'Rent made should be reflected on book' do
      expect(book.rentals.length).to eq 1
    end
  end

  context 'When rentals are made on a book:' do
    book = Book.new(title, author)
    classroom = Classroom.new('Frontend')
    student = Student.new(classroom, 20, 'Maximilianus', true)
    teacher = Teacher.new('Backend', 25, 'Zeus')
    it 'Rentals count should be zero(0) on initialization of Person instance' do
      expect(book.rentals.length).to eq 0
    end

    it 'Addition of rentals should be possible' do
      Rentals.new('2022/09/07', student, book)
      expect(book.rentals.length).to eq 1
    end

    it 'Should permit addition multiple different rentals' do
      Rentals.new('2022/10/01', book, teacher)
      Rentals.new('2022/11/14', book, student)
      expect(book.rentals.length).to eq 3
    end
  end
end
