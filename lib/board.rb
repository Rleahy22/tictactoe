require_relative "./square.rb"

class Board
  attr_reader :print_friendly, :squares, :winning_squares, :corners

  def initialize
    @squares = []
    9.times { @squares << Square.new(@squares.count + 1) }
    generate_print_friendly
    @winning_squares = [[@squares[0], @squares[1], @squares[2]],
                         [@squares[0], @squares[3], @squares[6]],
                         [@squares[0], @squares[4], @squares[8]],
                         [@squares[1], @squares[4], @squares[7]],
                         [@squares[2], @squares[4], @squares[6]],
                         [@squares[2], @squares[5], @squares[8]],
                         [@squares[3], @squares[4], @squares[5]],
                         [@squares[6], @squares[7], @squares[8]]]
    @corners = [0, 2, 6, 8].map { |index| @squares[index] }
  end

  def generate_print_friendly
    @print_friendly = ""
    @squares.each_slice(3) do |slice|
      slice.each { |square| @print_friendly << " #{square.value} |"}
      @print_friendly = @print_friendly[0..-2]
      @print_friendly << "\n-----------\n"
    end
    @print_friendly = print_friendly[0..-14]
  end

  def is_square_available?(num)
    @squares.each do |square|
      if square.value == num
        return true
      end
    end
    false
  end

  def find_square_values(squares)
    squares.map { |square| square.value}
  end
end