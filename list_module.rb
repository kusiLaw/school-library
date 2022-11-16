module List
  def list_all_book(with_index = false) # rubocop:disable Style/OptionalBooleanParameter
    @cache[:book]&.each_with_index do |item, i|
      if with_index
        puts "(#{i}) Title: #{item.title} Author: #{item.author} "
      else
        puts "Title: #{item.title} Author: #{item.author} "
      end
    end
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

  def list_rental
    puts 'ID of the person'
    list_all_people(false)
    id = gets.chomp
    puts 'Rentals: '
    i = @cache[:people].select { |person| person.id.to_i == id.to_i }
    i[0].rentals&.each do |item|
      puts "Date: #{item.date}, Book \"#{item.book.title}\" by #{item.book.author}" if item.person.id.to_i == id.to_i
    end
  end
end
