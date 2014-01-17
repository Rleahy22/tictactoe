require_relative "./spec_helper.rb"

describe "Square" do
  
  before { @square = Square.new(1) }

  describe '#initialize' do
    it "should create a new instance of Square" do
      expect(@square).to be_an_instance_of(Square)
    end
  end
end