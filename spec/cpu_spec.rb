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

  describe '#has_user_moved?' do
    describe "when there are no user marks" do
      it "should return false" do
        expect(@cpu.has_user_moved?).to eq(false)
      end
    end

    describe "when there is a user mark" do
      before { @game.user_player.place_mark(1) }
      it "should return true" do
        expect(@cpu.has_user_moved?).to eq(true)
      end
    end
  end

  describe '#middle_available?' do
    describe "when the middle square is available" do
      it "should return true" do
        expect(@cpu.middle_available?).to eq(true)
      end
    end

    describe "when the middle square is occupied" do
      before { @game.user_player.place_mark(5) }
      it "should return false" do
        expect(@cpu.middle_available?).to eq(false)
      end
    end
  end
end