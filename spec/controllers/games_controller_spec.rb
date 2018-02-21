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
      game = FactoryBot.create(:game, opponent: nil)
      put :update, params: { id: game.id, game: { opponent: user.id } }
      expect(response).to redirect_to new_user_session_path
    end
  end

    it "should successfully update attributes for opponent and go to game show page" do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game, opponent: nil)

      put :update, params: { id: game.id, game: { opponent: user.id } }
      expect(response).to redirect_to game_path(game)
    end
  end
end
