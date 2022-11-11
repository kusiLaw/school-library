require './app'

def welcome
  app = App.new
  until app.terminate
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - list all rental for a given person id'
    puts '7 - Exit'
    choice = gets.chomp
    app.entry(choice)
  end
end

def main
  welcome
end

main
