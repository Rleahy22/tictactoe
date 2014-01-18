require_relative "./spec_helper.rb"

describe "Game" do
  
  before { @game = Game.new }

  describe '#initialize' do
    it "should create a new instance of Game" do
      expect(@game).to be_an_instance_of(Game)
    end

    it "should create a user player" do
      expect(@game.user_player).to be_an_instance_of(User)
    end

    it "should create a computer player" do
      expect(@game.cpu_player).to be_an_instance_of(Cpu)
    end

    it "should create a board" do
      expect(@game.board).to be_an_instance_of(Board)
    end

    it "should designate a player to move first" do
      @game.should satisfy { |game| game.active_player.class == User or game.active_player.class == Cpu }
    end
  end

  describe '#choose_first_player' do
    before do
      @games = []
      20.times do
        @games << Game.new.active_player.class
      end
    end

    it "should randomly choose who goes first" do
      expect(@games.include?(User)).to eq(true)
      expect(@games.include?(Cpu)).to eq(true)
    end
  end

  describe '#switch_active_player' do
    describe "when cpu_player is active_player" do
      before do
        @game.active_player = @game.cpu_player
        @game.switch_active_player
      end
      it 'should set active_player equal to user_player' do
        expect(@game.active_player).to eq(@game.user_player)
      end
    end

    describe "when user_player is active_player" do
      before do
        @game.active_player = @game.user_player
        @game.switch_active_player
      end
      it "should set active player equal to cpu_player" do
        expect(@game.active_player).to eq(@game.cpu_player)
      end
    end
  end

  describe '#take_turn' do
    describe "when it is the cpu's turn" do
      before do
        @game.active_player = @game.cpu_player
        @previous_values = @game.board.squares.map { |square| square.value }
        @game.take_turn
        @current_values = @game.board.squares.map { |square| square.value }
      end
      it "should have the cpu place a mark on the board" do
        expect(@current_values.count("O")).to be > @previous_values.count("O")
      end

      it "should change the active_player to user_player" do
        expect(@game.active_player).to eq(@game.user_player)
      end
    end
  end

  describe '#game_over?' do
    describe "when there is no winner" do
      it "should return false" do
        expect(@game.game_over?).to eq(false)
      end
    end

    describe "when there is a winner" do
      before do
        @game.cpu_player.place_mark(1)
        @game.user_player.place_mark(6)
        @game.cpu_player.place_mark(5)
        @game.user_player.place_mark(8)
        @game.cpu_player.place_mark(9)
      end
      it "should return true" do
        expect(@game.game_over?).to eq(true)
      end
    end

    describe "when there is a cat's game" do
      before do
        @game.cpu_player.place_mark(1)
        @game.user_player.place_mark(9)
        @game.cpu_player.place_mark(5)
        @game.user_player.place_mark(3)
        @game.cpu_player.place_mark(6)
        @game.user_player.place_mark(4)
        @game.cpu_player.place_mark(8)
        @game.user_player.place_mark(2)
        @game.cpu_player.place_mark(7)
      end
      it "should return true" do
        expect(@game.game_over?).to eq(true)
      end
    end
  end

  describe '#is_a_draw' do
    describe "when the game is a draw" do
      before do
        @game.cpu_player.place_mark(1)
        @game.user_player.place_mark(9)
        @game.cpu_player.place_mark(5)
        @game.user_player.place_mark(3)
        @game.cpu_player.place_mark(6)
        @game.user_player.place_mark(4)
        @game.cpu_player.place_mark(8)
        @game.user_player.place_mark(2)
        @game.cpu_player.place_mark(7)
      end
      it "should return true" do
        expect(@game.is_a_draw?).to eq(true)
      end
    end

    describe "when the game is not a draw" do
      describe "when the game is not over" do
        it "should return false" do
          expect(@game.is_a_draw?).to eq(false)
        end
      end

      describe "when there is a winner" do
        before do
          @game.cpu_player.place_mark(1)
          @game.user_player.place_mark(6)
          @game.cpu_player.place_mark(5)
          @game.user_player.place_mark(8)
          @game.cpu_player.place_mark(9)
        end
        it "should return false" do
          expect(@game.is_a_draw?).to eq(false)
        end
      end
    end
  end

  describe '#is_cpu_winner' do
    describe "when the cpu is the winner" do
      before do
        @game.cpu_player.place_mark(1)
        @game.user_player.place_mark(6)
        @game.cpu_player.place_mark(5)
        @game.user_player.place_mark(8)
        @game.cpu_player.place_mark(9)
      end
      it "should return true" do
        expect(@game.is_cpu_winner?).to eq(true)
      end
    end

    describe "when the cpu is not the winner" do
      describe "when the game is not over" do
        it "should return false" do
          expect(@game.is_cpu_winner?).to eq(false)
        end
      end

      describe "when the game is a draw" do
        before do
          @game.cpu_player.place_mark(1)
          @game.user_player.place_mark(9)
          @game.cpu_player.place_mark(5)
          @game.user_player.place_mark(3)
          @game.cpu_player.place_mark(6)
          @game.user_player.place_mark(4)
          @game.cpu_player.place_mark(8)
          @game.user_player.place_mark(2)
          @game.cpu_player.place_mark(7)
        end
        it "should return false" do
          expect(@game.is_cpu_winner?).to eq(false)
        end
      end
    end
  end

  describe "winner" do
    describe "when it is a draw" do
      before do
        @game.cpu_player.place_mark(1)
        @game.user_player.place_mark(9)
        @game.cpu_player.place_mark(5)
        @game.user_player.place_mark(3)
        @game.cpu_player.place_mark(6)
        @game.user_player.place_mark(4)
        @game.cpu_player.place_mark(8)
        @game.user_player.place_mark(2)
        @game.cpu_player.place_mark(7)
        @game.game_over?
      end
      it "should declare no one is a winner" do
        expect(@game.winner).to eq("No one")
      end
    end

    describe "when the computer wins" do
      before do
        @game.cpu_player.place_mark(1)
        @game.user_player.place_mark(6)
        @game.cpu_player.place_mark(5)
        @game.user_player.place_mark(8)
        @game.cpu_player.place_mark(9)
        @game.game_over?
      end
      it "should declare the cpu the winner" do
        expect(@game.winner).to eq("CPU")
      end
    end
  end
end