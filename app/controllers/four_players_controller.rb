class FourPlayersController < ApplicationController
  def start_game
    cards = Card.all_shuffled_cards 4
  end
end
