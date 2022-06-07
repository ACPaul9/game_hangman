class ConsoleInterface
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"].
      sort.
      map { |file_name| File.read(file_name) }

  def initialize (game)
    @game = game
  end

  def print_out
    puts <<~END
      Слово: #{word_to_show}
      #{show_hanging.colorize(:blue)}
      Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}

    END

    if @game.won?
      puts "Вы победили"
    elsif @game.lose?
      puts "Вы проиграли, загаданное слово: #{@game.word}"
    end
  end

  def show_hanging
    FIGURES[@game.errors_made]
  end

  def word_to_show
    @game.letters_to_guess.map { |letter| letter || "__" }.join(" ")
  end

  def errors_to_show
    @game.errors.join(", ")
  end

  def get_input
    print "Введите следующию букву: "
    letter = gets[0].upcase
  end
end
