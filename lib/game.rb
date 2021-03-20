class Game
  ERRORS_MAX_NUMBER = 7

  def initialize(word)
    @word = word
    @letters = word.chars
    @user_guesses =[]
  end

  def word
    @letters.join
  end

  def errors_number # счетчик висельника
    errors.length
  end

  def remaining_attempts_number # оставшиеся попытки
    ERRORS_MAX_NUMBER - errors_number
  end

  def letters_to_guess
    @letters.map do |letter|
      letter if @user_guesses.include?(normalize_letter(letter))
    end
  end

  def errors # ошибочный ввод
    @user_guesses - normalized_letters(@letters)
  end

  def play!(letter)
    normalize_letter = normalize_letter(letter)
    if !over? &&  !@user_guesses.include?(normalize_letter)
      @user_guesses << normalize_letter
    end
  end

  def normalize_letter(letter)
    case letter
    when 'Ё' then 'Е'
    when 'Й' then 'И'
    else letter
    end
  end

  def normalized_letters(letters)
    letters.map { |letter| normalize_letter(letter) }
  end

#проверки окончания
  def won?
    (normalized_letters(@letters) - @user_guesses).empty?
  end

  def over?
    won? || lost?
  end

  def lost?
    remaining_attempts_number == 0
  end
end
