module Create
  def create_book
    puts 'title'
    title = gets.chomp
    puts 'author'
    author = gets.chomp
    @cache[:book] = [*@cache[:book], Book.new(title, author)]
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
end
