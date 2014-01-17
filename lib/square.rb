class Square
  attr_reader :value

  def initialize(position)
    @value = position
  end

  def update_value(new_value)
    @value = new_value
  end
end