class BadgesController < ApplicationController

  layout "application_with_admin_panel"

  before_filter :get_game

  # GET /badges
  # GET /badges.json
  def index
    @badges = @game.badges

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @badges }
    end
  end

  # GET /badges/1
  # GET /badges/1.json
  def show
    @badge = @game.badges.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @badge }
    end
  end

  # GET /badges/new
  # GET /badges/new.json
  def new
    @badge = Badge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @badge }
    end
  end

  # GET /badges/1/edit
  def edit
    @badge = Badge.find(params[:id])
  end

  # POST /badges
  # POST /badges.json
  def create
    @badge = @game.badges.new(params[:badge])

    respond_to do |format|
      if @badge.save
        format.html { redirect_to [@game, @badge], notice: 'Badge was successfully created.' }
        format.json { render json: [@game, @badge], status: :created, location: [@game, @badge] }
      else
        format.html { render action: "new" }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /badges/1
  # PUT /badges/1.json
  def update
    @badge = @game.badges.find(params[:id])

    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        format.html { redirect_to [@game, @badge], notice: 'Badge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /badges/1
  # DELETE /badges/1.json
  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to game_badges_url }
      format.json { head :no_content }
    end
  end

  # Used for getting the game each user is associated with.
  def get_game
    @game = Game.find(params[:game_id])
  end
end
