require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#new action" do
    it "should successfully show the page" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#update action" do
    it "should not allow unauthenticated users to join a game" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user, opponent: nil)
      # put :update, params: { id: game.id, game: { opponent: nil } }
      get :show, params: { id: game.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully update attributes for opponent and go to game show page" do
      user1 = FactoryBot.create(:user)
      # user1 = users[1]
      user2 = FactoryBot.create(:user)
      sign_in user2
      game = FactoryBot.create(:game, owner: user1, opponent: nil)
      patch :update, params: { id: game.id, game: { owner: user1, opponent: user2 } }
      expect(response).to redirect_to game_path(game)
    end
  end
