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
  end
end