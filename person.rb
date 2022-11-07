class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unkown', parent_permission = true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def of_age?
    if @age >= 18
      true
    else
      false
    end
  end

  def can_use_services?
    if of_age? && @parent_permission
      true
    else
      false
    end
  end
end

p = Person.new(11, 'law')
puts p.of_age?, p.can_use_services?
