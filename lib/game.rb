require_relative "./user.rb"
require_relative "./cpu.rb"
require_relative "./board.rb"

class Game
  attr_reader :user_player, :cpu_player, :board, :active_player

  def initialize
    @board = Board.new
    @user_player = User.new("X", @board)
    @cpu_player = Cpu.new("O", @board)
    @active_player = choose_first_player
  end

  def choose_first_player
    rand(2) == 0 ? @cpu_player: @user_player
  end

  def print_board
    puts @board.generate_print_friendly
  end

  def take_turn
    print_board
    puts "\n"
    selection = nil
    if @active_player == @user_player
      until @board.is_square_available?(selection)
        puts "Into which square would you like to place your mark?"
        selection = gets.chomp.to_i
      end
        @user_player.place_mark(selection)
    else
      @cpu_player.place_mark(@cpu_player.best_move)
      puts "CPU has made it's move"
    end
    puts "\n"
    print_board
  end
end