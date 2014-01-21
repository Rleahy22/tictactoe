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

  describe '#is_square_available?' do
    describe "when the square is available" do
      it "should return true" do
        expect(@board.is_square_available?(5)).to eq(true)
      end
    end

    describe "when the square is taken" do
      before { @board.squares[1].update_value("X") }
      it "should return false" do
        expect(@board.is_square_available?(2)).to eq(false)
      end
    end
  end

  describe '#find_square_values' do
    describe "when neither player has moved" do
      it "should return the orignal values of squares in argument" do
        expect(@board.find_square_values(@board.squares)).to eq([1,2,3,4,5,6,7,8,9])
      end
    end

    describe "when players have moved" do
      before do
        @board.squares[0].update_value("X")
        @board.squares[4].update_value("O")
      end
      it "should return the updated values of the squares in argument" do
        expect(@board.find_square_values(@board.squares)).to eq(["X",2,3,4,"O",6,7,8,9])
      end
    end

    describe "when given a specific group of squares" do
      describe "when neither player has moved" do
        it "should return the orignal values of the squares in argument" do
          expect(@board.find_square_values(@board.corners)).to eq([1,3,7,9])
        end
      end

      describe "when players have moved" do
        before do
          @board.squares[0].update_value("X")
          @board.squares[8].update_value("O")
        end
        it "should return the updated values of the squares in argument" do
        expect(@board.find_square_values(@board.corners)).to eq(["X",3,7,"O"])
      end
      end
    end
  end

  describe "squares" do
    before { @squares = @board.find_square_values(@board.squares) }
    it "should be an array of all the available squares" do
      expect(@squares).to eq([1,2,3,4,5,6,7,8,9])
    end
  end

  describe "winning_squares" do
    before { @winning_combo = @board.find_square_values(@board.winning_squares[1]) }
    it "should be a mutlidimensional array of winning square combinations" do
      expect(@winning_combo).to eq([1,4,7])
    end
  end

  describe "corners" do
    before { @corners = @board.find_square_values(@board.corners) }
    it "should be an array of the corner squares" do
      expect(@corners).to eq([1,3,7,9])
    end
  end

  describe "edges" do
    before { @edges = @board.find_square_values(@board.edges) }
    it "should be an array of the edge squares" do
      expect(@edges).to eq([2,4,6,8])
    end
  end

  describe "opposite_corners" do
    before { @opposite_corners = @board.opposite_corners.map { |pair| @board.find_square_values(pair)} }
    it "should return a mulitdimensional array of the opposite corner pairs" do
      expect(@opposite_corners).to eq([[1,9], [3,7]])
    end
  end
end