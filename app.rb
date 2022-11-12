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

  def entry(choice) # rubocop:disable Metrics/CyclomaticComplexity
    case choice
    when '1'
      list_all_book
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rent
    when '6'
      list_rental
    when '7'
      @terminate = true

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

  def list_all_book(with_index = false) # rubocop:disable Style/OptionalBooleanParameter
    @cache[:book]&.each_with_index do |item, i|
      if with_index
        puts "(#{i}) Title: #{item.title} Author: #{item.author} "
      else
        puts "Title: #{item.title} Author: #{item.author} "
      end
    end
  end

  def create_student
    puts 'Name?'
    name = gets.chomp
    puts 'Age?'
    age = gets.chomp
    puts 'Parent permission?[y/n]'
    permission = gets.chomp
    @cache[:people] = [*@cache[:people], Student.new(age, '', name, permission.upcase == 'Y')]
  end

  def create_teacher
    puts 'Name?'
    name = gets.chomp
    puts 'Age?'
    age = gets.chomp
    puts 'Specialization?'
    specialization = gets.chomp
    @cache[:people] = [*@cache[:people], Teacher.new(age, specialization, name)]
  end

  def create_person
    puts 'Do you want to create a student(1) or a teacher (2) for teacher' \
         '[input a number]'
    gets.chomp == '1' ? create_student : create_teacher
  end

  def list_all_people(with_index = false) # rubocop:disable Style/OptionalBooleanParameter
    @cache[:people]&.each_with_index do |item, i|
      if with_index
        puts "(#{i})[#{item.class.name}] Name: #{item.name} ID: #{item.id} Age: #{item.age}"
      else
        puts "[#{item.class.name}] Name: #{item.name} ID: #{item.id} Age: #{item.age}"
      end
    end
  end

  def create_rent
    puts 'Select a book from a following list by number'
    list_all_book(true)
    book_index = gets.chomp
    puts 'Select a person from the following list by number(not id)'
    list_all_people(true)
    person_index = gets.chomp
    puts 'Date'
    date = gets.chomp
    begin
      person = @cache[:people][book_index.to_i]
      book = @cache[:book][person_index.to_i]
      @cache[:rental] = [*@cache[:rental], Rentals.new(date, book, person)]
    rescue StandardError => e
      puts "incorrect value #{e}"
    end
  end

  def list_rental
    puts 'ID of the person'
    id = gets.chomp
    puts 'Rentals: '
    @cache[:rental]&.each do |item|
      puts "Date: #{item.date}, Book \"#{item.book.title}\" by #{item.book.author}" if item.person.id.to_i == id.to_i
    end
  end
end
