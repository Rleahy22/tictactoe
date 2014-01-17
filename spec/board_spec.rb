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
end