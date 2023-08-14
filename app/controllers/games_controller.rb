require 'open-uri'

class GamesController < ApplicationController

    def new
        @letters = []
        10.times { @letters << ('A'..'Z').to_a.sample }
    end

    def score

        @word = params[:tried]
        @letters = params[:letters]
        @is_in_grid = @word.upcase.chars.all? { |letter| @letters.include?(letter) && @word.upcase.count(letter) <= @letters.count(letter) }
        if @is_in_grid
            @is_english = is_english(@word)
            if @is_english
                @message = "Congratulations! #{@word} is a valid English word!"
            else
                @message = "Sorry but #{@word} does not seem to be a valid English word..."
            end
        else
            @message = "Sorry but #{@word} contains letters that are not in the grid"
        end
    end

    private

    def is_english(word)
        url = "https://wagon-dictionary.herokuapp.com/#{word}"
        response = URI.open(url).read
        json = JSON.parse(response)
        json['found']
    end
end
