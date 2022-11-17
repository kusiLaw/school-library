require_relative '../book'
require_relative '../classroom'
require_relative '../teacher'
require_relative '../student'
require_relative '../rentals'

describe Person do
  context 'Person could be created' do
    name = 'Maximilianus', age = 100
    it 'Created person created should be an instance of Person' do
      person = Person.new(age, name, parent_permission: true)
      expect(person).to be_an_instance_of Person
    end
  end

  context 'Person could be created without optional arguments' do
    person = Person.new(20)
    it 'Created person without name should have name as "Unknown"' do
      expect(person.name).to eq 'Unknown'
    end

    it 'Created person without parent_permission should have parent_permission as "true"' do
      expect(person.parent_permission).to eq true
    end

    it 'Created person without parent_permission should have "can_use_service?" as "true"' do
      expect(person.can_use_services?).to eq true
    end
  end

  context 'Attributes should match arguments for created persons' do
    person = Person.new(13, 'Zeus', false)
    it 'Age attribute of Person instance should match age argument' do
      expect(person.age).to eq 13
    end

    it 'Name attribute of Person instance should match name argument' do
      expect(person.name).to eq 'Zeus'
    end

    it 'Permission attribute of Person instance should match permission argument' do
      expect(person.parent_permission).to eq false
    end
  end

  context 'Attributes should be mutable for created persons' do
    person = Person.new(13, 'Zeus', parent_permission: true)
    it 'Age attribute of Person instance should be mutable' do
      person.age = 15
      expect(person.age).to eq 15
    end

    it 'Name attribute of Person instance should be mutable' do
      person.name = 'Maximilianus'
      expect(person.name).to eq 'Maximilianus'
    end

    it 'Permission attribute of Person instance should be mutable' do
      person.parent_permission = false
      expect(person.parent_permission).to eq false
    end
  end

  context 'When rentals are made by instance of Person' do
    person = Person.new(13, 'Zeus', parent_permission: true)
    book = Book.new('Introduction to FrontEnd', 'Elon Musk')
    it 'Rentals count should be zero(0) on initialization' do
      expect(person.rentals.length).to eq 0
    end

    it 'Addition of rentals should be possible' do
      Rentals.new('2022/09/07', person, book)
      expect(person.rentals.length).to eq 1
    end

    it 'Should permit addition of multiple different rentals' do
      Rentals.new('2022/10/01', person, book)
      Rentals.new('2022/11/14', person, book)
      expect(book.rentals.length).to eq 3
    end
  end
end
