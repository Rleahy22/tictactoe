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