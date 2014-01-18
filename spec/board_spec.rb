require_relative "./spec_helper.rb"

describe "Board" do
  
  before { @board = Board.new }

  describe '#initialize' do
    it "should create an instance of board" do
      expect(@board).to be_an_instance_of(Board)
    end
  end

  describe 'print_friendly' do
    before { @board.generate_print_friendly }
    it "should be a print friendly string of the board" do
      expect(@board.print_friendly).to eq(" 1 | 2 | 3 \n-----------\n 4 | 5 | 6 \n-----------\n 7 | 8 | 9 ")
    end
  end

  describe '#generate_print_friendly' do
    before { @board.generate_print_friendly }
    it "should create update print_friendly to reflect the current game state" do
      expect(@board.print_friendly).to eq(" 1 | 2 | 3 \n-----------\n 4 | 5 | 6 \n-----------\n 7 | 8 | 9 ")
    end
  end

  describe '#find_square_values' do
    it "should return the values of squares in argument" do
      expect(@board.find_square_values(@board.squares)).to eq([1,2,3,4,5,6,7,8,9])
    end
  end

  describe "squares" do
    before { @squares = @board.find_square_values(@board.squares) }
    it "should be an array of all the available squares" do
      expect(@squares).to eq([1,2,3,4,5,6,7,8,9])
    end
  end

  describe "corners" do
    before { @corners = @board.find_square_values(@board.corners) }
    it "should be an array of the corner squares" do
      expect(@corners).to eq([1,3,7,9])
    end
  end
end