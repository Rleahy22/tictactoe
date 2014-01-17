Dir["/lib/*.rb"].each { |file| require file }

class Cpu
  attr_reader :mark, :board

  def initialize(mark, board)
    @mark = mark
    @board = board
  end

  def check_for_immediate_threats
    @board.winning_squares.each do |winning_combo|
      winning_combo.map! { |square| square.value }
      if winning_combo.count("X") == 2
        unless winning_combo.include?("O")
          winning_combo.delete("X")
          return winning_combo.first
        end
      end
    end
    false
  end

  def has_user_moved?
    @board.squares.each do |square|
      if square.value == "X"
        return true
      end
    end
    false
  end
end