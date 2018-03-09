class Game < ApplicationRecord
  attr_accessor :owner, :opponent
  after_create :populate_game!
  # after_create  :set_turn

  belongs_to :owner, class_name: 'User' , foreign_key: 'owner'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent', optional: true
  has_many :pieces

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent_id = nil) }

  def populate_game!
    Rook.create(game_id: self.id, moves: 0, position_x: 0, position_y: 0, color: "white", captured: false, user: owner)
    Knight.create(game_id: self.id, moves: 0, position_x: 1, position_y: 0, color: "white", captured: false, user: owner)
    Bishop.create(game_id: self.id, moves: 0, position_x: 2, position_y: 0, color: "white", captured: false, user: owner)
    King.create(game_id: self.id, moves: 0, position_x: 3, position_y: 0, color: "white", captured: false, user: owner)
    Queen.create(game_id: self.id, moves: 0, position_x: 4, position_y: 0, color: "white", captured: false, user: owner)
    Bishop.create(game_id: self.id, moves: 0, position_x: 5, position_y: 0, color: "white", captured: false, user: owner)
    Knight.create(game_id: self.id, moves: 0, position_x: 6, position_y: 0, color: "white", captured: false, user: owner)
    Rook.create(game_id: self.id, moves: 0, position_x: 7, position_y: 0, color: "white", captured: false, user: owner)

    (0..7).each do |n|
      Pawn.create(game_id: self.id, moves: 0, position_x: n, position_y: 1, color: "white", captured: false, user: owner)
    end

    Rook.create(game_id: self.id, moves: 0, position_x: 0, position_y: 7, color: "black", captured: false, user: opponent)
    Knight.create(game_id: self.id, moves: 0, position_x: 1, position_y: 7, color: "black", captured: false, user: opponent)
    Bishop.create(game_id: self.id, moves: 0, position_x: 2, position_y: 7, color: "black", captured: false, user: opponent)
    King.create(game_id: self.id, moves: 0, position_x: 3, position_y: 7, color: "black", captured: false, user: opponent)
    Queen.create(game_id: self.id, moves: 0, position_x: 4, position_y: 7, color: "black", captured: false, user: opponent)
    Bishop.create(game_id: self.id, moves: 0, position_x: 5, position_y: 7, color: "black", captured: false, user: opponent)
    Knight.create(game_id: self.id, moves: 0, position_x: 6, position_y: 7, color: "black", captured: false, user: opponent)
    Rook.create(game_id: self.id, moves: 0, position_x: 7, position_y: 7, color: "black", captured: false, user: opponent)

    (0..7).each do |n|
      Pawn.create(game_id: self.id, moves: 0, position_x: n, position_y: 6, color: "black", captured: false, user: opponent)
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


  def set_turn
    self.turn == self.owner
  end 


  def update_turn
    if self.turn == self.owner
      update_attributes(turn: self.opponent)
    else self.turn == self.opponent
      update_attributes(turn: self.owner)
    end 
  end 

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured, :image)
  end
end 