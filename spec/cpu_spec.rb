require_relative "./spec_helper.rb"

describe "Cpu" do
  
  before { @cpu = Cpu.new("O", Board.new) }

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
end