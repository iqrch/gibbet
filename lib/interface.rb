class Interface
  IMAGES = Dir[File.join(__dir__ , "/../data/figures/*.txt")].sort.map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~GAME_STATUS
      Слово: #{word_to_show}
      #{image_to_show}
      Ошибок допущено #{@game.errors_number}
      Ошибочные буквы #{errors_to_show}

    GAME_STATUS

    if @game.won?
      puts "Поздравляем, вы выиграли!"
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}"
    end
  end

  def image_to_show # печать виселицы
    IMAGES[@game.errors_number]
  end

  def word_to_show # маскированное слово
    result = @game.letters_to_guess.map do |letter|
      if letter.nil?
        "__"
      else
        letter
      end
    end
    result.join(" ")
  end

  def errors_to_show # печать ошибок
    @game.errors.join(',')
  end

  def user_input
    print "Введите букву: "
    gets[0].upcase
  end
end
