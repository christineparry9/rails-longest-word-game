require "open-uri"
require "json"

class GamesController < ApplicationController

  def new
  @letters = ('a'..'z').to_a.shuffle[0..9]
  end


  def included
    @letters = params[:letters]
    word = params[:word]
    word.chars.all? { |letter| word.count(letter) <= @letters.count(letter) }
  end


  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    serialized = URI.open(url).read
    hash = JSON.parse(serialized)
    if hash['found'] != true
      @result = "Sorry but #{@word} does not seem to be an English word."
    elsif hash['found'] = true && included
      @result = "Congratulations"
    elsif hash['found'] = true && !included
      @result = "you used the wrong letters"
    end

  end


end
