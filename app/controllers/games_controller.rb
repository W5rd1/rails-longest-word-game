require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    until @letters.length == 10
      @letters << ('a'..'z').to_a.sample.upcase
    end
  end

  def score
    panel = params[:letters].split
    guess = params[:guess].upcase.chars
    x = guess.all? do |letter|
      guess.count(letter) <= panel.count(letter)
    end
    url = "https://wagon-dictionary.herokuapp.com/#{params[:guess]}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    if word['found'] == true && x == true
      @answer = "Congratulations #{guess.join} is an English word!"
    elsif x == true
      @answer = "You didn't guess an English word"
    else
      @answer = "Your guess wasn't an english word or matched the given characters"
    end
  end
end
