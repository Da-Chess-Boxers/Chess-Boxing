class Knight < Piece
  scope :piece, -> {where(type: 'Knight')}

  def valid_move?(new_x, new_y)
    (self.position_x - new_x).abs + (self.position_y - new_y).abs == 3 &&
    (self.position_x - new_x).abs != 0 &&
    (self.position_y - new_y).abs != 0
  end

end 
