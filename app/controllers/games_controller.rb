class GamesController < ApplicationController
  def new
    @letters = generate_letters(10)
  end
    def generate_letters(size)
      Array.new(size) { ('A'..'Z').to_a.sample }
    end

  def score
    @word = params[:word].upcase
    @letters = params[:letter]&.split(" ") || []

    if valid_from_grid?(@word, @letters)
      if valid_english_word?(@word)
        @result = "Congratulations! #{@word} is a valid English word."
      else
        @result = "Sorry, but #{@word} is not a valid English word."
      end
    else
      @result = "Sorry, but #{@word} can't be built from #{@letters.join(', ')}."
    end
  end

    def valid_from_grid?(word, letters)
      word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    end

    def valid_english_word?(word)
      url = "https://dictionary.lewagon.com/#{word}"
      response = URI.open(url).read
      json = JSON.parse(response)
      json['found']
    end

end
