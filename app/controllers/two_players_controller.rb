class TwoPlayersController < ApplicationController
  def start_game
    cards = Card.all_shuffled_cards 2
  end
end
