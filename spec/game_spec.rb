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
end