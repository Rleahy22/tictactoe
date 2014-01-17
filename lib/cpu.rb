Dir["/lib/*.rb"].each { |file| require file }

class Cpu
  attr_reader :mark, :board

  def initialize(mark, board)
    @mark = mark
    @board = board
  end
end