require './person'

class Teacher < Person
  def initialize(age, specialization, name = 'Unkown', parent_permission = true)
    super(age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

p = Teacher.new(24, 'I.T', 'law')
puts p.of_age?, p.can_use_services?
