require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#new action" do
    it "should successfully show the page" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end