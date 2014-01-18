Dir["/lib/*.rb"].each { |file| require file }

class Cpu
  attr_reader :mark, :board, :winning_move, :response_to_threat

  def initialize(mark, board)
    @mark = mark
    @board = board
  end

  def place_mark(square)
    @board.squares[square - 1].update_value(@mark)
  end

  def best_move
    if is_winning_move?
      return @winning_move
    end
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
    remaining_squares = @board.find_square_values(@board.squares)
    remaining_squares.delete("X")
    remaining_squares.delete("O")
    remaining_squares
  end

  def is_immediate_threat?
    @board.winning_squares.each do |winning_combo|
      current_values = @board.find_square_values(winning_combo)
      if current_values.count("X") == 2
        unless current_values.include?("O")
          set_response_to_threat(current_values)
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

  def is_winning_move?
    @board.winning_squares.each do |winning_combo|
      current_values = @board.find_square_values(winning_combo)
      if current_values.count("O") == 2
        unless current_values.include?("X")
          set_winning_move(current_values)
          return true
        end
      end
    end
    false
  end

  def set_winning_move(squares)
    squares.delete("O")
    @winning_move = squares.first
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