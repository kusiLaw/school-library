require './student'
require './classroom'
require './book'
require './rentals'
require './person'
require './teacher'
require './list_module'
require './create_module'

class App
  include List
  include Create

  attr_accessor :cache, :terminate

  def initialize
    @cache = {}
    @terminate = false
  end

  def entry(choice)
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
    end
  end
end
