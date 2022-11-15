require './nameable'
require './rentals'

class Person < Nameable
  attr_accessor :name, :age, :rentals, :parent_permission
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission = true) # rubocop:disable Style/OptionalBooleanParameter
    @id = Random.rand(1..1000)
    super()
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(book, date)
    @rentals.push(Rentals.new(date, book, self))
  end

  private

  def of_age?
    @age >= 18
  end
end
