require 'json'
require 'fileutils'
require './book'
require './teacher'
require './student'
require './classroom'
require './rentals'

module Storage
  def import_people
    people_store = 'storage/people.json'
    if File.exist?(people_store)
      JSON.parse(File.read(people_store)).map do |person|
        if person['instance'] == 'teacher'
          Teacher.new(person['age'], person['specialization'], person['name'])
        else
          Student.new(person['age'], person['classroom'], person['name'], person['permission'])
        end
      end
    else
      []
    end
  end

  def import_books
    book_store = 'storage/books.json'
    if File.exist? book_store
      JSON.parse(File.read(book_store)).map do |book|
        Book.new(book['title'], book['author'])
      end
    else
      []
    end
  end

  def import_rentals
    rental_store = 'storage/rentals.json'
    if File.exist? rental_store
      JSON.parse(File.read(rental_store)).map do |rental|
        date = rental['date']
        person = identify_person(rental['person'])
        book = identify_book(rental['book']['title'], rental['book']['author'])
        Rentals.new(date, book, person)
      end
    else
      []
    end
  end

  def store_people
    people_catalogue = []
    @cache[:people].each do |person|
      if person.instance_of?(Teacher)
        people_catalogue.push({ type: 'teacher', name: person.name, age: person.age,
                                specialization: person.specialization })
      else
        people_catalogue.push({ type: 'student', name: person.name, age: person.age,
                                permission: person.parent_permission, classroom: person.classroom })
      end
    end
    File.write('storage/people.json', JSON.generate(people_catalogue))
  end

  def store_rental
    rental_catalogue = []
    @cache[:rental].each do |rental|
      rental_catalogue.push({ date: rental.date,
                              person: { name: rental.person.name, age: rental.person.age },
                              book: { title: rental.book.title, author: rental.book.author } })
    end
    File.write('storage/rentals.json', JSON.generate(rental_catalogue))
  end

  def store_books
    book_catalogue = []
    @cache[:book].each do |book|
      book_catalogue.push({ title: book.title, author: book.author })
    end
    File.write('storage/books.json', JSON.generate(book_catalogue))
  end

  def store_data
    FileUtils.mkdir_p('storage')
    store_people unless @cache[:people].empty?
    store_books unless @cache[:book].empty?
    store_rental unless @cache[:rental].empty?
  end
end

# HELPER METHODS
# -----Method to identify person who made a rental
def identify_person(rental_person)
  @cache[:people].find do |person|
    person.name == rental_person['name'] && person.age == rental_person['age']
  end
end

# -----Method to identify book rented
def identify_book(title, author)
  @cache[:book].find do |book|
    book.title == title && book.author == author
  end
end
