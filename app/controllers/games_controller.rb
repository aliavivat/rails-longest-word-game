require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].capitalize.split('')
    @letters = params[:letters].split('')
    # raise
    @included = included?(@letters, @word)
    @english_word = english_word?(@word)
  end

  private

  def included?(letters, word)
    letters.count(word)
  end

  def english_word?(word)
    # return either true or false
    url = "https://wagon-dictionary.herokuapp.com/#{word.join}"
    response = URI.open(url)
    info = JSON.parse(response.read)
    info['found']
  end
end
