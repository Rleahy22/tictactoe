require_relative "./spec_helper.rb"

describe "Board" do
  
  before { @board = Board.new }

  describe '#initialize' do
    it "should create an instance of board" do
      expect(@board).to be_an_instance_of(Board)
    end
  end
end