require_relative "./spec_helper.rb"

describe "Square" do
  
  before { @square = Square.new(1) }

  describe '#initialize' do
    it "should create a new instance of Square" do
      expect(@square).to be_an_instance_of(Square)
    end

    it "should set square's initial value to it's corresponding place on the board" do
      expect(@square.value).to eq(1)
    end
  end

  describe '#update_value' do
    before { @square.update_value("X") }
    it "should update value to reflect player's move" do
      expect(@square.value).to eq("X")
    end
  end
end