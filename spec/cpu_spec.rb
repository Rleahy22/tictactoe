require_relative "./spec_helper.rb"

describe "Cpu" do
  
  before do
    @game = Game.new
    @cpu = @game.cpu_player
    @user = @game.user_player
    @board= @game.board
  end

  describe '#initialize' do
    it "should create a new instance of Cpu" do
      expect(@cpu).to be_an_instance_of(Cpu)
    end

    it "should set mark to 'O'" do
      expect(@cpu.mark).to eq("O")
    end

    it "should give the computer access to the game board" do
      expect(@board).to be_an_instance_of(Board)
    end
  end

  describe '#find_remaining_squares' do
    before do
      @user.place_mark(1)
      @cpu.place_mark(5)
      @user.place_mark(4)
      @cpu.place_mark(7)
    end
    it "should return the an array of squares that are unoccupied" do
      expect(@cpu.find_remaining_squares).to eq([2,3,6,8,9])
    end
  end

  describe '#is_immediate_threat' do
    describe "when there are 2 X's and no O's on a winning combo" do
      before do
        @user.place_mark(1)
        @user.place_mark(2)
      end
      it "should return true" do
        expect(@cpu.is_immediate_threat?).to eq(true)
      end
    end

    describe "when there are no winning combo's with 2 X's and no O's" do
      it "should return false" do
        expect(@cpu.is_immediate_threat?).to eq(false)
      end
    end
  end

  describe '#set_response_to_threat' do
    before do
      @user.place_mark(1)
      @user.place_mark(2)
      squares = @board.winning_squares.first.map { |square| square.value}
      @cpu.set_response_to_threat(squares)
    end
    it "should return the winning move" do
      expect(@cpu.response_to_threat).to eq(3)
    end
  end

  describe '#is_winning_move?' do
    describe "when there is no winning move" do
      it "should return false" do
        expect(@cpu.is_winning_move?).to eq(false)
      end
    end

    describe "when there is a winning move" do
      before do
        @cpu.place_mark(1)
        @cpu.place_mark(2)
      end
      it "should return true" do
        expect(@cpu.is_winning_move?).to eq(true)
      end
    end
  end

  describe '#set_winning_move' do
    before do
      @cpu.place_mark(1)
      @cpu.place_mark(2)
      squares = @board.winning_squares.first.map { |square| square.value}
      @cpu.set_winning_move(squares)
    end
    it "should return the winning move" do
      expect(@cpu.winning_move).to eq(3)
    end
  end

  describe '#has_user_moved?' do
    describe "when there are no user marks" do
      it "should return false" do
        expect(@cpu.has_user_moved?).to eq(false)
      end
    end

    describe "when there is a user mark" do
      before { @user.place_mark(1) }
      it "should return true" do
        expect(@cpu.has_user_moved?).to eq(true)
      end
    end
  end

  describe '#has_cpu_moved?' do
    describe "when there are no cpu marks" do
      it "should return false" do
        expect(@cpu.has_cpu_moved?).to eq(false)
      end
    end

    describe "when there is a cpu mark" do
      before { @cpu.place_mark(1) }
      it "should return true" do
        expect(@cpu.has_cpu_moved?).to eq(true)
      end
    end
  end

  describe '#is_middle_available?' do
    describe "when the middle square is available" do
      it "should return true" do
        expect(@cpu.is_middle_available?).to eq(true)
      end
    end

    describe "when the middle square is occupied" do
      before { @user.place_mark(5) }
      it "should return false" do
        expect(@cpu.is_middle_available?).to eq(false)
      end
    end
  end

  describe '#are_corners_available?' do
    describe "when a corner is available" do
      it "should return true" do
        expect(@cpu.are_corners_available?).to eq(true)
      end
    end

    describe "when all corners are occupied" do
      before do
        @user.place_mark(1)
        @user.place_mark(3)
        @user.place_mark(7)
        @user.place_mark(9)
      end
      it "should return false" do
        expect(@cpu.are_corners_available?).to eq(false)
      end
    end
  end

  describe 'find_best_corner' do
    before do
      @cpu.place_mark(1)
      @user.place_mark(2)
      @corners = @board.find_square_values(@board.corners)
    end
    it "should return the corner with no X's in the winning combo it belongs to" do
      expect([7,9].include?(@cpu.find_best_corner(@corners))).to eq(true)
    end
  end

  describe '#best_move' do
    describe "when there isn't an immediate opportunity to win" do
      describe "when the player has made the first move" do
        describe "when the player has taken the middle square" do
          before { @user.place_mark(5) }
          it "should return one of the remaining squares" do
            expect([1,2,3,4,6,7,8,9]).to include(@cpu.best_move)
          end
        end

        describe "when the player has not taken the middle square" do
          before { @user.place_mark(1) }
          it "should return the middle square" do
            expect(@cpu.best_move).to eq(5)
          end
        end
      end

      describe "when both the player and computer have moved already" do
        describe "when there is no immediate threat" do
          before do
            @user.place_mark(2)
            @cpu.place_mark(5)
            @user.place_mark(4)
          end
          it "should return one of the remaining squares" do
              expect([1,3,6,7,8,9]).to include(@cpu.best_move)
          end
        end

        describe "when there is an immediate threat" do
          before do
            @user.place_mark(1)
            @cpu.place_mark(5)
            @user.place_mark(3)
          end
          it "should return the square that ends the threat" do
            expect(@cpu.best_move).to eq(2)
          end
        end
      end

      describe "when the cpu has the first move" do
        it "should return a corner square" do
          expect(@cpu.best_move).to eq(1)
        end
      end
    end

    describe "when there is an immediate opportunity to win" do
      before do
        @cpu.place_mark(1)
        @user.place_mark(4)
        @cpu.place_mark(5)
        @user.place_mark(3)
      end
      it "should return the square that wins the game" do
        expect(@cpu.best_move).to eq(9)
      end
    end
  end
end