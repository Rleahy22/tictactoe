require_relative "./square.rb"

class Board
  attr_reader :print_friendly

  def initialize
    @squares = []
    9.times { @squares << Square.new(@squares.count + 1) }
    generate_print_friendly
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
end