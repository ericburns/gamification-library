class InventoriesController < ApplicationController

  layout "application_with_admin_panel"

  before_filter :get_game
  before_filter :get_user

  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = @user.inventories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventories }
    end
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    @inventory = @user.inventories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/new
  # GET /inventories/new.json
  def new
    @inventory = Inventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/1/edit
  def edit
    @inventory = Inventory.find(params[:id])
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = @user.inventories.new(params[:inventory])

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to [@game, @user, @inventory], notice: 'Inventory was successfully created.' }
        format.json { render json: [@game, @user, @inventory], status: :created, location: [@game, @user, @inventory] }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventories/1
  # PUT /inventories/1.json
  def update
    @inventory = @user.inventories.find(params[:id])

    respond_to do |format|
      if @inventory.update_attributes(params[:inventory])
        format.html { redirect_to [@game, @user, @inventory], notice: 'Inventory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory = @user.inventories.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to game_user_inventories_url }
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
