class Deck < ActiveRecord::Base
  has_many :cards
  after_create :fill_deck


  def fill_deck
    %w(club heart spade diamond).each do |suit|
      %w(2 3 4 5 6 7 8 9 10 J Q K A).each do |value|
        Card.create(:suit => suit, :value => value.to_s)
      end
    end
  end

end
