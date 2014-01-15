require_relative "./spec_helper.rb"

describe "Game" do
  
  before { @game = Game.new }

  describe '#initialize' do
    it "should create a new instance of Game" do
      expect(@game).to be_an_instance_of(Game)
    end
  end
end