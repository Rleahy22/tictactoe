Dir["/lib/*.rb"].each { |file| require file }

class Game
  attr_reader :user_player

  def initialize
    @user_player = User.new
  end
end