Dir["/lib/*.rb"].each { |file| require file }

class User
  attr_reader :mark, :board

  def initialize(mark, board)
    @mark = mark
    @board = board
  end

  def place_mark(square)
    puts (@board.squares[square - 1].value)
    @board.squares[square - 1].update_value(@mark)
    puts (@board.squares[square - 1].value)
  end
end