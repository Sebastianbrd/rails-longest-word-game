require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...9).map { (65 + rand(26)).chr }
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    @included = included?(@word)
    @match = match?(@letters, @word)
    if @included && @match
      @result = "<strong>Congratulations!</strong> #{@word} is a valid word!"
    elsif @included
      @result = "Sorry but #{@word} can't be built out of #{@letters.join(",")}"
    else
      @result = "Sorry but #{@word} does not seem to be a valid English word"
    end
  end

  private

  def included?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    words_serialized = open(url).read
    words = JSON.parse(words_serialized)
    words['found'] ? true : false
  end

  def match?(letters, word)
    letters.downcase
  end
end
