require './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'Unkown', parent_permission = true) # rubocop:disable Style/OptionalBooleanParameter
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky?
    "¯'\\(ツ)/¯"
  end
end
