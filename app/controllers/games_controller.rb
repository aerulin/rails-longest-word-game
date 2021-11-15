require 'open-uri'
require 'nokogiri'

class GamesController < ApplicationController
  def new
    @letters = [*('a'..'z')].sample(10)
    @regex = Regexp.new @letters.join
  end

  def score
    @input = params[:input]
    letters = params[:letters].chars
    if @input.chars.all? { |letter| @input.count(letter) > letters.count(letter) }
      @message = "You did not use the correct letters"
    else
      json_result = URI.open("https://wagon-dictionary.herokuapp.com/#{@input}").read
      @hash_result = JSON.parse(json_result)
      if @hash_result["found"]
        @message = "Great job this is english!"
      else
        @message = "#{@hash_result["error"]} try again!"
      end
    end
  end
end
