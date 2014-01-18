require_relative "./spec_helper.rb"

describe "Cpu" do
  
  before do
    @game = Game.new
    @cpu = @game.cpu_player
  end

  describe '#initialize' do
    it "should create a new instance of Cpu" do
      expect(@cpu).to be_an_instance_of(Cpu)
    end

    it "should set mark to 'O'" do
      expect(@cpu.mark).to eq("O")
    end

    it "should give the computer access to the game board" do
      expect(@cpu.board).to be_an_instance_of(Board)
    end
  end

  describe '#is_immediate_threat' do
    describe "when there are 2 X's and no O's on a winning combo" do
      before do
        @game.user_player.place_mark(1)
        @game.user_player.place_mark(2)
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

  describe '#is_winning_move?' do
    describe "when there is no winning move" do
      it "should return false" do
        expect(@cpu.is_winning_move?).to eq(false)
      end
    end

    describe "when there is a winning move" do
      before do
        @game.cpu_player.place_mark(1)
        @game.cpu_player.place_mark(2)
      end
      it "should return true" do
        expect(@cpu.is_winning_move?).to eq(true)
      end
    end
  end

  describe '#has_user_moved?' do
    describe "when there are no user marks" do
      it "should return false" do
        expect(@cpu.has_user_moved?).to eq(false)
      end
    end

    describe "when there is a user mark" do
      before { @game.user_player.place_mark(1) }
      it "should return true" do
        expect(@cpu.has_user_moved?).to eq(true)
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
      before { @game.user_player.place_mark(5) }
      it "should return false" do
        expect(@cpu.is_middle_available?).to eq(false)
      end
    end
  end

  describe '#best_move' do
    describe "when the player has made the first move" do
      describe "when the player has taken the middle square" do
        before { @game.user_player.place_mark(5) }
        it "should return one of the remaining squares" do
          expect([1,2,3,4,6,7,8,9]).to include(@cpu.best_move)
        end
      end

      describe "when the player has not taken the middle square" do
        before { @game.user_player.place_mark(1) }
        it "should return the middle square" do
          expect(@cpu.best_move).to eq(5)
        end
      end
    end

    describe "when both the player and computer have moved already" do
      describe "when there is no immediate threat" do
        before do
          @game.user_player.place_mark(2)
          @cpu.place_mark(5)
          @game.user_player.place_mark(4)
        end
        it "should return one of the remaining squares" do
            expect([1,3,6,7,8,9]).to include(@cpu.best_move)
        end
      end

      describe "when there is an immediate threat" do
        before do
          @game.user_player.place_mark(1)
          @cpu.place_mark(5)
          @game.user_player.place_mark(3)
        end
        it "should return the square that ends the threat" do
          expect(@cpu.best_move).to eq(2)
        end
      end
    end
  end
end