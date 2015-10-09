class Card < ActiveRecord::Base
  belongs_to :deck

  def self.all_shuffled_cards number_of_players
    @cards = Card.all
    @shuffled_cards = @cards.order('random()')
    number_of_players == 2 ? (Card.two_players_game @shuffled_cards) : (Card.four_players_game @shuffled_cards)
  end

  def self.two_players_game shuffled_cards
    @player_one_must_card = shuffled_cards.where(value: %w(9 10 J Q K)).first
    shuffled_cards = shuffled_cards.where.not("value = ? and suit = ?", @player_one_must_card.value, @player_one_must_card.suit)

    shuffled_cards = shuffled_cards.to_a
    @initial_floor_cards = shuffled_cards.pop(4)

    shuffled_cards = shuffled_cards.in_groups(2)
    @player_two_cards = shuffled_cards[0]
    shuffled_cards[1].pop
    @player_one_cards = shuffled_cards[1] << @player_one_must_card
    return @initial_floor_cards, @player_one_cards, @player_two_cards
  end

  def self.four_players_game shuffled_cards
    @player_one_must_card = shuffled_cards.where(value: %w(9 10 J Q K)).first
    shuffled_cards = shuffled_cards.where.not("value = ? and suit = ?", @player_one_must_card.value, @player_one_must_card.suit)

    shuffled_cards = shuffled_cards.to_a
    @initial_floor_cards = shuffled_cards.pop(4)


    shuffled_cards = shuffled_cards.in_groups(4)
    @player_two_cards = shuffled_cards[0]
    @player_three_cards = shuffled_cards[1]
    @player_four_cards = shuffled_cards[2]
    shuffled_cards[3].pop
    @player_one_cards = shuffled_cards[3] << @player_one_must_card
    return @initial_floor_cards, @player_one_cards, @player_two_cards, @player_three_cards, @player_four_cards
  end

end
