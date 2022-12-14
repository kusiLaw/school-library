require './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission = true, id = -1) # rubocop:disable Style/OptionalBooleanParameter
    super(age, name, parent_permission, id)
    @classroom = classroom
  end

  def play_hooky?
    "¯'\\(ツ)/¯"
  end

  def assign_classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
