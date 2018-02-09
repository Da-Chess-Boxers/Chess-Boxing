class Game < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs to :opponent, class_name: "User", foreign_key: "opponent_id"
end
