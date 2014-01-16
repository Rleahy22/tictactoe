Dir["/lib/*.rb"].each { |file| require file }

class Game
  attr_reader :user_player, :cpu_player, :board, :active_player

  def initialize
    @user_player = User.new
    @cpu_player = Cpu.new
    @board = Board.new
    @active_player = choose_first_player
  end

  def choose_first_player
    rand(2) == 0 ? @cpu_player: @user_player
  end
end