class GamesController < ApplicationController
  def index
    @games = Game.available
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.owner = current_user
    @game.save!
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.valid? && @game.owner_id != current_user
      @game.update_attributes(:opponent => current_user)
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def game_params
    params.require(:game).permit(:name, :owner, :opponent, :game_id)
  end

end
