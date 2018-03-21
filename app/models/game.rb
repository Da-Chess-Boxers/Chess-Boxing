class Game < ApplicationRecord
  attr_accessor :owner, :opponent
  after_create :populate_game!

  belongs_to :owner, class_name: 'User' , foreign_key: 'owner_id'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent', optional: true
  has_many :pieces

  scope :available, -> { where(Game.arel_table[:owner_id].not_eq(0)).where(opponent_id = nil) }

  def populate_game!
    Rook.create(type: "Rook", game_id: self.id, moves: 0, position_x: 0, position_y: 0, color: "white", captured: false)
    Knight.create(type: "Knight", game_id: self.id, moves: 0, position_x: 1, position_y: 0, color: "white", captured: false)
    Bishop.create(type: "Bishop", game_id: self.id, moves: 0, position_x: 2, position_y: 0, color: "white", captured: false)
    King.create(type: "King", game_id: self.id, moves: 0, position_x: 3, position_y: 0, color: "white", captured: false)
    Queen.create(type: "Queen", game_id: self.id, moves: 0, position_x: 4, position_y: 0, color: "white", captured: false)
    Bishop.create(type: "Bishop", game_id: self.id, moves: 0, position_x: 5, position_y: 0, color: "white", captured: false)
    Knight.create(type: "Knight", game_id: self.id, moves: 0, position_x: 6, position_y: 0, color: "white", captured: false)
    Rook.create(type: "Rook", game_id: self.id, moves: 0, position_x: 7, position_y: 0, color: "white", captured: false)

    (0..7).each do |n|
      Pawn.create(type: "Pawn", game_id: self.id, moves: 0, position_x: n, position_y: 1, color: "white", captured: false)
    end

    Rook.create(type: "Rook", game_id: self.id, moves: 0, position_x: 0, position_y: 7, color: "black", captured: false)
    Knight.create(type: "Knight", game_id: self.id, moves: 0, position_x: 1, position_y: 7, color: "black", captured: false)
    Bishop.create(type: "Bishop", game_id: self.id, moves: 0, position_x: 2, position_y: 7, color: "black", captured: false)
    King.create(type: "King", game_id: self.id, moves: 0, position_x: 3, position_y: 7, color: "black", captured: false)
    Queen.create(type: "Queen", game_id: self.id, moves: 0, position_x: 4, position_y: 7, color: "black", captured: false)
    Bishop.create(type: "Bishop", game_id: self.id, moves: 0, position_x: 5, position_y: 7, color: "black", captured: false)
    Knight.create(type: "Knight", game_id: self.id, moves: 0, position_x: 6, position_y: 7, color: "black", captured: false)
    Rook.create(type: "Rook", game_id: self.id, moves: 0, position_x: 7, position_y: 7, color: "black", captured: false)

    (0..7).each do |n|
      Pawn.create(type: "Pawn", game_id: self.id, moves: 0, position_x: n, position_y: 6, color: "black", captured: false)
    end
  end

  def in_check?
    if self.pieces.find_by(type: 'King', color: 'black') != nil
      black_in_check?
    elsif self.pieces.find_by(type: 'King', color: 'white') != nil
      white_in_check?
    else
      return false
    end
  end

  def black_in_check?
    black_king = self.pieces.find_by(type: 'King', color: 'black')
    position_x = black_king.position_x
    position_y = black_king.position_y

    self.pieces.each do |piece|
      if piece.valid_move?(position_x, position_y) && piece.color == 'white'
        return true
      end
    end
    return false
  end


  def white_in_check?
    white_king = self.pieces.find_by(type: 'King', color: 'white')
    position_x = white_king.position_x
    position_y = white_king.position_y

    # binding.pry

    pieces.where(color: 'black', game_id: self).each do |piece|
      if piece.valid_move?(position_x, position_y) == true # && piece.color == 'black'
        return true
      end
    end
    return false
  end

  def is_occupied?(destination_x, destination_y)
    Piece.find_by(game_id: self, position_x: destination_x, position_y: destination_y).present?
  end

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured, :image)
  end
end
