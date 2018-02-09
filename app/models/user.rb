class User < ApplicationRecord
  has_many :started_games, class_name: "Game", foreign_key: "owner_id"
  has_many :opponent_games, class_name: "Game", foreign_key: "opponent_id"
end
