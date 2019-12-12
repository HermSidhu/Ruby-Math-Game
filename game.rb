require "./player"
require "./question"

class Game
  attr_accessor :player1, :player2, :current_player, :game_over

  def initialize(player1_name, player2_name)
    @player1 = Player.new(player1_name)
    @player2 = Player.new(player2_name)
    @current_player = player1
    @game_over = false
  end

  def start
    while !self.game_over
      question = Question.new
      question.ask(current_player)
      answer = $stdin.gets.chomp.to_i
      if (!question.check_answer(answer))
        current_player === player1 ? player1.dec_life : player2.dec_life
        if player1.lives == 0 || player2.lives == 0
          self.game_over = true
        end
        message(false)
      else 
        message(true)
      end
    end
  end

  def message(correct)
    puts correct ? "#{current_player.name}: Yes, you are correct!" : "#{current_player.name} No, you're wrong!"
    puts "#{player1.name}: #{player1.score} vs. #{player2.name}: #{player2.score}"
    if (game_over)
      puts current_player.name == player1.name ? "#{player2.name} wins with a score of #{player2.score}" : "#{player1.name} wins with a score of #{player1.score}"
      puts "----- GAME OVER -----"
      puts "Good Bye!"
      exit(0)
    else
      puts "----- NEW TURN -----"
      next_player
    end
  end
  
  def next_player
    if (current_player.name == player1.name)
      self.current_player = player2
    else 
      self.current_player = player1
    end
  end
end