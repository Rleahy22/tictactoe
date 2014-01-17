require_relative "./spec_helper.rb"

describe "User" do
  
  before { @user= User.new("X", Board.new) }

  describe '#initialize' do
    it "should create a new instance of user" do
      expect(@user).to be_an_instance_of(User)
    end

    it "should set mark to 'X'" do
      expect(@user.mark).to eq("X")
    end

    it "should give the user access to the game board" do
      expect(@user.board).to be_an_instance_of(Board)
    end
  end

  describe '#place_mark' do
    before { @user.place_mark(3) }
    it "places user's mark in the appropriate square" do
      expect(@user.board.squares[2].value).to eq("X")
    end
  end
end