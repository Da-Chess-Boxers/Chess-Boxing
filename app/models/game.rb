class Game < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent_id'

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent = nil) }

  def populate_game!(piece_params)
    Piece.create("Rook", 0, 0, @game.id, "white", false)
    Piece.create("Knight", 1, 0, @game.id, "white", false)
    Piece.create("Bishop", 2, 0, @game.id, "white", false)
    Piece.create("King", 3, 0, @game.id, "white", false)
    Piece.create("Queen", 4, 0, @game.id, "white", false)
    Piece.create("Bishop", 5, 0, @game.id, "white", false)
    Piece.create("Knight", 6, 0, @game.id, "white", false)
    Piece.create("Rook", 7, 0, @game.id, "white", false)

    (0..7).each do |n|
      Piece.create("Pawn", n, 1, @game.id, "white", false)
    end

    Piece.create("Rook", 0, 7, @game.id, "black", false)
    Piece.create("Knight", 1, 7, @game.id, "black", false)
    Piece.create("Bishop", 2, 7, @game.id, "black", false)
    Piece.create("King", 3, 7, @game.id, "black", false)
    Piece.create("Queen", 4, 7, @game.id, "black", false)
    Piece.create("Bishop", 5, 7, @game.id, "black", false)
    Piece.create("Knight", 6, 7, @game.id, "black", false)
    Piece.create("Rook", 7, 7, @game.id, "black", false)

    (0..7).each do |n|
      Piece.create("Pawn", n, 6, @game.id, "black", false)
    end
  end

  private


  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured)
  end
end
