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
        if person['type'] == 'teacher'
          Teacher.new(person['age'], person['specialization'], person['name'], person['id'])
        else
          Student.new(person['age'], person['classroom'], person['name'], person['permission'], person['id'])
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
      rent_obj = JSON.parse(File.read(rental_store))
      rent_obj[0].keys.map do |id| # get all keys
        person = identify_person_object(id) # get person by keys
        person_rents = rent_obj[0][id]['rent'] # rent from the rent json
        person_rents.each do |rent|
          date = rent['date']
          book = identify_book_object(rent['title'], rent['author'])
          Rentals.new(date, book[0], person[0])
        end
      end
    else
      []
    end
  end

  def updat_rental()
    import_rentals
  end

  def store_people
    people_catalogue = []
    @cache[:people].each do |person|
      if person.instance_of?(Teacher)
        people_catalogue.push({ type: 'teacher', id: person.id, name: person.name, age: person.age,
                                specialization: person.specialization })
      else
        people_catalogue.push({ type: 'student', id: person.id, name: person.name, age: person.age,
                                permission: person.parent_permission, classroom: person.classroom })
      end
    end
    File.write('storage/people.json', JSON.generate(people_catalogue))
  end

  def store_rental
    rental_catalogue = []
    rental_object = {}
    @cache[:people].each do |person|
      next unless person.rentals.length.positive?

      person_rent = person.rentals.map do |rental|
        { title: rental.book.title, author: rental.book.author, date: rental.date }
      end

      rental_object[person.id] = {
        person: { name: person.name, age: person.age },
        rent: person_rent
      }
    end

    rental_catalogue.push(rental_object)
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

  # HELPER METHODS
  # -----Method to identify person who made a rental
  def identify_person_object(id)
    @cache[:people].select { |person| person.id.to_i == id.to_i }
  end

  # -----Method to identify book rented
  def identify_book_object(title, author)
    @cache[:book].select do |book|
      book.title == title && book.author == author
    end
  end
end
