require './student'
require './classroom'
require './book'
require './rentals'
require './person'
require './teacher'

class App
  attr_accessor :cache, :terminate

  def initialize
    @cache = {}
    @terminate = false
  end

  def entry(choice)
    case choice
    when '1'
      list_all_book
    when '3'
      puts 'Do you want to create a student(1) or a teacher (2) for teacher' \
           '[input a number]'
      gets.chomp == '1' ? create_student : create_teacher
    when '4'
      create_book
    when '7'
      @terminate = true
    else
      'Enter valid value. either 1 or 2'
    end
  end

  private

  def create_book
    puts 'title'
    title = gets.chomp
    puts 'author'
    author = gets.chomp
    @cache[:book] = [*@cache[:book], Book.new(title, author)]
  end

  def list_all_book
    # @cache[:book].each do |item|
    #   puts item.
    # end
  end

  def list_all_people
    # people = @cache[:student] +  @cache[:teacher]
    # people.each do |item|
    #  puts item
    # end
  end

  def create_student
    puts 'Name?'
    name = gets.chomp
    puts 'Age?'
    age = gets.chomp
    puts 'Parent permission?[y/n]'
    permission = gets.chomp
    @cache[:student] = [*@cache[:student], Student.new(age, '', name, permission.upcase == 'Y')]
  end

  def create_teacher
    puts 'Name?'
    name = gets.chomp
    puts 'Age?'
    age = gets.chomp
    puts 'Specialization?'
    specialization = gets.chomp
    @cache[:teacher] = [*@cache[:teacher], Teacher.new(age, specialization, name)]
  end

  def create_person(person_type = 1)
    case person_type
    when 1 # student

      @cache[:student] = [*@cache[:student], Student.new(age, '', name, permission)]
    when 2 # teacher
      puts 'Name?'
      name = gets.chomp
      puts 'Age?'
      age = gets.chomp
      puts 'Specialization?'
      specialization = gets.chomp
      @cache[:teacher] = [*@cache[:teacher], Teacher.new(age, specialization, name)]
    else
      'Enter valid value. either 1 or 2'
    end
  end
end
