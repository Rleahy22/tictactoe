require_relative "./spec_helper.rb"

describe "Cpu" do
  
  before { @cpu = Cpu.new }

  describe '#initialize' do
    it "should create a new instance of Cpu" do
      expect(@cpu).to be_an_instance_of(Cpu)
    end
  end
end