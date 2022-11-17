require_relative '../book'
require_relative '../classroom'
require_relative '../student'
require_relative '../rentals'

describe Student do
  context 'Student could be created:' do
    name = 'Maximilianus', age = 100, classroom = Classroom.new('Frontend')
    it 'Created student should be an instance of Student' do
      student = Student.new(age, classroom, name, true)
      expect(student).to be_an_instance_of Student
    end
  end

  context 'Student could be created without optional arguments:' do
    classroom = Classroom.new('Frontend')
    student = Student.new(20, classroom)
    it 'Created student without name should have name as "Unknown"' do
      expect(student.name).to eq 'Unknown'
    end

    it 'Created student without parent_permission should have parent_permission as "true"' do
      expect(student.parent_permission).to eq true
    end

    it 'Created student without parent_permission should have "play_hooky?" as "¯\'\\(ツ)/¯"' do
      expect(student.play_hooky?).to eq "¯'\\(ツ)/¯"
    end
  end

  context 'Attributes should match arguments for created students:' do
    classroom = Classroom.new('Backend')
    student = Student.new(13, classroom, 'Zeus', false)
    it 'Age attribute of Student instance should match age argument' do
      expect(student.age).to eq 13
    end

    it 'Name attribute of Student instance should match name argument' do
      expect(student.name).to eq 'Zeus'
    end

    it 'Permission attribute of Student instance should match permission argument' do
      expect(student.parent_permission).to eq false
    end
  end

  context 'Attributes should be mutable for created student:' do
    classroom = Classroom.new('Fullstack')
    student = Student.new(13, classroom, 'Zeus', true)
    it 'Age attribute of Student instance should be mutable' do
      student.age = 15
      expect(student.age).to eq 15
    end

    it 'Name attribute of Student instance should be mutable' do
      student.name = 'Maximilianus'
      expect(student.name).to eq 'Maximilianus'
    end

    it 'Permission attribute of Student instance should be mutable' do
      student.parent_permission = false
      expect(student.parent_permission).to eq false
    end
  end

  context 'When rentals are made by instance of Student:' do
    classroom = Classroom.new('Fullstack')
    book = Book.new('Introduction to FrontEnd', 'Elon Musk')
    student = Student.new(13, classroom, 'Zeus', true)
    it 'Rentals count should be zero(0) on initialization' do
      expect(student.rentals.length).to eq 0
    end

    it 'Addition of rentals should be possible' do
      Rentals.new('2022/09/07', book, student)
      expect(student.rentals.length).to eq 1
    end

    it 'Should permit addition of multiple different rentals' do
      Rentals.new('2022/10/01', book, student)
      Rentals.new('2022/11/14', book, student)
      expect(book.rentals.length).to eq 3
    end
  end
end
