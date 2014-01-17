Dir["/lib/*.rb"].each { |file| require file }

class User
  attr_reader :mark, :board

  def initialize(mark, board)
    @mark = mark
    @board = board
  end

  def place_mark(square)
    @board.squares[square - 1].update_value(@mark)
  end
end