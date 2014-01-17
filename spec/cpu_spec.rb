require_relative "./spec_helper.rb"

describe "Cpu" do
  
  before do
    @game = Game.new
    @cpu = @game.cpu_player
  end

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

  describe '#check_for_immediate_threats' do
    before do
      @game.user_player.place_mark(1)
      @game.user_player.place_mark(2)
    end
    it "should identify move that addresses immediate threat" do
      expect(@cpu.check_for_immediate_threats).to eq(3)
    end
  end
end