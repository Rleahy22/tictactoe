require_relative "./user.rb"
require_relative "./cpu.rb"
require_relative "./board.rb"

class Game
  attr_reader :user_player, :cpu_player, :board, :winner
  attr_accessor :active_player

  def initialize
    @board = Board.new
    @user_player = User.new("X", @board)
    @cpu_player = Cpu.new("O", @board)
    @active_player = choose_first_player
  end

  def choose_first_player
    rand(2) == 0 ? @cpu_player: @user_player
  end

  def play
    print_board
    until game_over?
      take_turn
    end
    display_winner
  end

  def print_board
    puts "\n"
    puts @board.generate_print_friendly
    puts "\n"
  end

  def take_turn
    if @active_player == @user_player
      @user_player.place_mark(receive_user_input)
    else
      @cpu_player.place_mark(@cpu_player.best_move)
      puts "CPU has made it's move"
    end
    switch_active_player
    print_board
  end

  def receive_user_input
    selection = nil
    until @board.is_square_available?(selection)
      puts "Into which square would you like to place your mark?"
      selection = gets.chomp.to_i
    end
    selection
  end

  def switch_active_player
    @active_player == @cpu_player ? @active_player = @user_player : @active_player = @cpu_player 
  end

  def game_over?
    @board.winning_squares.each do |winning_combo|
      current_values = winning_combo.map { |square| square.value }
      if current_values.count("O") == 3
        @winner = "CPU"
        return true
      end
    end
    @board.squares.each do |square|
      if square.value != "X" && square.value != "O"
        return false
      end  
    end
    @winner = "No one"
    return true
  end

  def display_winner
    puts "#{@winner} has won the game!"
  end
end