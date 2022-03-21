class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    word.upcase
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @letters.map do |letter|
      if @user_guesses.include?(normalize_letter(letter))
        letter
      end
    end
  end

  def lose?
    errors_allowed == 0
  end

  def over?
    won? || lose?
  end

  def play!(letter)
    new_letter = normalize_letter(letter)
    if !over? && !@user_guesses.include?(new_letter)
      @user_guesses << new_letter
    end
  end

  def word
    @letters.join
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def normalize_letter(letter)
    if letter == "Ё"
      "Е"
    elsif letter == "Й"
      "И"
    else
      letter
    end
  end

  def normalized_letters
    @letters.map do |letter|
      normalize_letter(letter)
    end
  end
end
