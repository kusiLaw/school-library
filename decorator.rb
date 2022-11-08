require './nameable'

class BaseDecorator < Nameable
  attr_accessor :nameable

  def initialize(param)
    super()
    @nameable = param
  end

  def correct_name()
    @nameable.correct_name
  end
end

class CapitalizeDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.upcase
  end
end

class TrimmerDecorator < BaseDecorator
  def correct_name
    name = @nameable.correct_name
    name.length > 10 ? name[0...10] : name
  end
end
