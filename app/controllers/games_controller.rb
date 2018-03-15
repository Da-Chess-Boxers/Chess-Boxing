class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :update, :show ]

  def index
    @games = Game.available
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.update_attributes(:owner => current_user)
    @game.save!
    redirect_to root_path
  end

  def show
    @game = Game.find_by_id(params[:id])
    @pieces = Piece.where(game_id: @game)
    return render text: "Not Found", status: :not_found if @game.blank? 
    redirect_to new_user_session_path if !user_signed_in?
  end
    

  def update
    @game = Game.find(params[:id])
    if @game.owner != current_user.id
      @game.update_attribute(:opponent, current_user)
      @game.save
      if current_user.in_check?
        flash[:alert] = "You're in check!"
      end
    redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def game_params
    params.require(:game).permit(:name, :owner, :opponent)
  end

end
