Dir["/lib/*.rb"].each { |file| require file }

class Cpu
  attr_reader :mark, :board

  def initialize(mark, board)
    @mark = mark
    @board = board
  end

  def place_mark(square)
    @board.squares[square - 1].update_value(@mark)
  end

  def best_move
    if is_immediate_threat?
      return @response_to_threat
    end
    if has_user_moved?
      if is_middle_available?
        return 5
      end
    end
    find_remaining_squares.sample
  end

  def find_remaining_squares
    remaining_squares = @board.squares.map { |square| square.value }
    remaining_squares.delete("X")
    remaining_squares.delete("O")
    remaining_squares
  end

  def is_immediate_threat?
    @board.winning_squares.each do |winning_combo|
      winning_combo.map! { |square| square.value }
      if winning_combo.count("X") == 2
        unless winning_combo.include?("O")
          set_response_to_threat(winning_combo)
          return true
        end
      end
    end
    false
  end

  def set_response_to_threat(squares)
    squares.delete("X")
    @response_to_threat = squares.first
  end

  def has_user_moved?
    @board.squares.each do |square|
      if square.value == "X"
        return true
      end
    end
    false
  end

  def is_middle_available?
    @board.squares[4].value == 5
  end
end