Dir["/lib/*.rb"].each { |file| require file }

class Game
  attr_reader :user_player, :cpu_player

  def initialize
    @user_player = User.new
    @cpu_player = Cpu.new
  end
end