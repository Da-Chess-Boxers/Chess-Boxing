require 'rails_helper'

RSpec.describe Piece, type: :model do

  context 'is_obstructed?' do
    it 'should detect if there are vertical obstructions between a piece and desired destination' do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      game.pieces.destroy_all
      piece_1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = FactoryBot.create(:piece, position_x: 0, position_y: 2, game_id: game.id)
      expect(piece_1.is_obstructed?(0,7)).to eq(true)
    end

    it 'should detect if there are no vertical obstructions between a piece and desired destination' do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      game.pieces.destroy_all
      piece_1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = FactoryBot.create(:piece, position_x: 0, position_y: 7, game_id: game.id)
      expect(piece_1.is_obstructed?(0,2)).to eq(false)
    end

    it 'should detect diagonal obstructions between a piece and desired destination' do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      game.pieces.destroy_all
      piece_1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = FactoryBot.create(:piece, position_x: 2, position_y: 2, game_id: game.id)
      expect(piece_1.is_obstructed?(3,3)).to eq(true)
    end

    it 'should detect if there are horizontal obstructions between a piece and desired destination' do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      game.pieces.destroy_all
      piece_1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = FactoryBot.create(:piece, position_x: 2, position_y: 0, game_id: game.id)

      # user = FactoryBot.create(:user)
      # game = Game.create(id: 1, owner: user)
      # game.pieces.destroy_all
      # piece_1 = Piece.create(position_x: 0, position_y: 0, game_id: game.id)
      # piece_2 = Piece.create(position_x: 2, position_y: 0, game_id: game.id)
      expect(piece_1.is_obstructed?(5,0)).to eq(true)
    end

    it 'should detect if there are no horizontal obstructions between a piece and desired destination' do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      game.pieces.destroy_all
      piece_1 = FactoryBot.create(:piece, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = FactoryBot.create(:piece, position_x: 5, position_y: 0, game_id: game.id)

      # user = FactoryBot.create(:user)
      # game = Game.create(id: 1, owner: user)
      # game.pieces.destroy_all
      # piece_1 = Piece.create(position_x: 0, position_y: 0, game_id: game.id)
      # piece_2 = Piece.create(position_x: 5, position_y: 0, game_id: game.id)
      expect(piece_1.is_obstructed?(2,0)).to eq(false)
    end

  end
end
