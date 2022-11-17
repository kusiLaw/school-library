require_relative '../book'
require_relative '../teacher'
require_relative '../rentals'

describe Teacher do
  context 'Teacher could be created:' do
    name = 'Maximilianus', age = 100, spec = 'Frontend'
    it 'Created teacher should be an instance of Teacher' do
      teacher = Teacher.new(age, spec, name)
      expect(teacher).to be_an_instance_of Teacher
    end
  end

  context 'Teacher could be created without optional arguments:' do
    teacher = Teacher.new(29, 'Frontend')
    it 'Created teacher without name should have name as "Unknown"' do
      expect(teacher.name).to eq 'Unknown'
    end

    it 'Created teacher without parent_permission should have parent_permission as "true"' do
      expect(teacher.parent_permission).to eq true
    end

    it 'Created teacher without parent_permission should have "can_use_services?" as "true"' do
      expect(teacher.can_use_services?).to eq true
    end
  end

  context 'Attributes should match arguments for created teachers:' do
    teacher = Teacher.new(31, 'Backend', 'Zeus')
    it 'Age attribute of Teacher instance should match age argument' do
      expect(teacher.age).to eq 31
    end

    it 'Name attribute of Teacher instance should match name argument' do
      expect(teacher.name).to eq 'Zeus'
    end

    it 'Specialization attribute of Teacher instance should match name argument' do
      expect(teacher.specialization).to eq 'Backend'
    end
  end

  context 'Attributes should be mutable for created teacher:' do
    teacher = Teacher.new(35, 'Fullstack', 'Zeus', true)
    it 'Age attribute of Student instance should be mutable' do
      teacher.age = 45
      expect(teacher.age).to eq 45
    end

    it 'Name attribute of Teacher instance should be mutable' do
      teacher.name = 'Maximilianus'
      expect(teacher.name).to eq 'Maximilianus'
    end

    it 'Specialization attribute of Teacher instance should be mutable' do
      teacher.specialization = 'Backend'
      expect(teacher.specialization).to eq 'Backend'
    end
  end

  context 'When rentals are made by instance of Teacher:' do
    book = Book.new('Introduction to FrontEnd', 'Elon Musk')
    teacher = Teacher.new(13, 'Fullstack', 'Zeus', true)
    it 'Rentals count should be zero(0) on initialization' do
      expect(teacher.rentals.length).to eq 0
    end

    it 'Addition of rentals should be possible' do
      Rentals.new('2022/09/07', teacher, book)
      expect(teacher.rentals.length).to eq 1
    end

    it 'Should permit addition of multiple different rentals' do
      Rentals.new('2022/10/01', teacher, book)
      Rentals.new('2022/11/14', teacher, book)
      expect(book.rentals.length).to eq 3
    end
  end
end
