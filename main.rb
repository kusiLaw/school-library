require './app'

def main
  app = App.new
  until app.terminate
    puts 'Please choose an option by entering a number:
    1 - List all books
    2 - List all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - list all rental for a given person id
    7 - Exit'
    choice = gets.chomp
    if choice == '7'
      app.store_data
      app.terminate = true
    end
    app.entry(choice)
  end
  puts 'Thank you for using this app!'
end

main
