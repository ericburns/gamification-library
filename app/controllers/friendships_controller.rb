class FriendshipsController < ApplicationController

  layout "application_with_admin_panel"

  before_filter :get_game
  before_filter :get_user

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = @user.friendships

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friendships }
    end
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @friendship = @user.friendships.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/new
  # GET /friendships/new.json
  def new
    @friendship = Friendship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/1/edit
  def edit
    @friendship = Friendship.find(params[:id])
  end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = @user.friendships.new(params[:friendship])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to [@game, @user, @friendship], notice: 'Friendship was successfully created.' }
        format.json { render json: [@game, @user, @friendship], status: :created, location: [@game, @user, @friendship] }
      else
        format.html { render action: "new" }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friendships/1
  # PUT /friendships/1.json
  def update
    @friendship = @user.friendships.find(params[:id])

    respond_to do |format|
      if @friendship.update_attributes(params[:friendship])
        format.html { redirect_to [@game, @user, @friendship], notice: 'Friendship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = @user.friendships.find(params[:id])
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to game_user_friendships_url }
      format.json { head :no_content }
    end
  end

  # Used for getting the game each user is associated with.
  def get_game
    @game = Game.find(params[:game_id])
  end

  def get_user
    @user = get_game.users.find(params[:user_id])
  end
end
