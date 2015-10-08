class CardsController < ApplicationController

  def all_shuffled_cards number_of_players
    @cards = Card.all
    @shuffled_cards = @cards.order('random()')
    number_of_players == 2 ? (two_players_game @shuffled_cards) : (four_players_game @shuffled_cards)
  end

  def two_players_game shuffled_cards
    @player_one_must_card = shuffled_cards.where(value: %w(9 10 J Q K)).first
    shuffled_cards = shuffled_cards.where.not("value = ? and suit = ?", @player_one_must_card.value, @player_one_must_card.suit)

    @initial_floor_cards = shuffled_cards.first(limit = "4")
    shuffled_cards = shuffled_cards.where.not("value = ? and suit = ?", @initial_floor_cards[0].value, @initial_floor_cards[0].suit).where.not("value = ? and suit = ?", @initial_floor_cards[1].value, @initial_floor_cards[1].suit).where.not("value = ? and suit = ?", @initial_floor_cards[2].value, @initial_floor_cards[2].suit).where.not("value = ? and suit = ?", @initial_floor_cards[3].value, @initial_floor_cards[3].suit)

    shuffled_cards = shuffled_cards.in_groups(2)
    @player_two_cards = shuffled_cards[0]
    shuffled_cards[1].pop
    @player_one_cards = shuffled_cards[1] << @player_one_must_card
    @initial_floor_cards = @player_one_rest_cards
    return @initial_floor_cards, @player_one_cards, @player_two_cards
  end

  def four_players_game shuffled_cards
    @player_one_must_card = shuffled_cards.where(value: %w(9 10 J Q K)).first
    shuffled_cards = shuffled_cards.where.not("value = ? and suit = ?", @player_one_must_card.value, @player_one_must_card.suit)

    @initial_floor_cards = shuffled_cards.first(limit = "4")
    shuffled_cards = shuffled_cards.where.not("value = ? and suit = ?", @player_one_rest_cards[0].value, @player_one_rest_cards[0].suit).where.not("value = ? and suit = ?", @player_one_rest_cards[1].value, @player_one_rest_cards[1].suit).where.not("value = ? and suit = ?", @player_one_rest_cards[2].value, @player_one_rest_cards[2].suit).where.not("value = ? and suit = ?", @player_one_rest_cards[3].value, @player_one_rest_cards[3].suit)


    shuffled_cards = shuffled_cards.in_groups(4)
    @player_two_cards = shuffled_cards[0]
    @player_three_cards = shuffled_cards[1]
    @player_four_cards = shuffled_cards[2]
    shuffled_cards[3].pop
    @player_one_cards = shuffled_cards[3] << @player_one_must_card
    return @initial_floor_cards, @player_one_cards, @player_two_cards, @player_three_cards, @player_four_cards
  end

end
