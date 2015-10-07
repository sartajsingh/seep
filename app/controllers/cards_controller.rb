class CardsController < ApplicationController

  def all_shuffled_cards number_of_players
    @cards = Card.all
    @suffled_cards = @cards.shuffle
    number_of_players == 2 ? (two_players_game @shuffled_cards) : (four_players_game @shuffled_cards)
  end

  def two_players_game shuffled_cards
    shuffled_cards = shuffled_cards.each_slice(52 / 2).to_a
    @player_one_cards = shuffled_cards[0]
    @player_two_cards = shuffled_cards[1]
    return @player_one_cards, @player_two_cards
  end

  def four_players_game shuffled_cards
    shuffled_cards = shuffled_cards.each_slice(52 / 4).to_a
    @player_one_cards = shuffled_cards[0]
    @player_two_cards = shuffled_cards[1]
    @player_three_cards = shuffled_cards[2]
    @player_four_cards = shuffled_cards[3]
    return @player_one_cards, @player_two_cards, @player_three_cards, @player_four_cards
  end

end
