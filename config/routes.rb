Rails.application.routes.draw do
  get "/start_two_players_game" => "two_players#start_game"
  get "/start_four_players_game" => "four_players#start_game"
end
