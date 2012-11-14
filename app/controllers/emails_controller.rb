class EmailsController < ApplicationController

  layout "application_with_admin_panel"

  before_filter :get_game
  before_filter :get_user

  # GET /emails
  # GET /emails.json
  def index
    @emails = @user.emails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emails }
    end
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
    @email = @user.emails.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @email }
    end
  end

  # GET /emails/new
  # GET /emails/new.json
  def new
    @email = Email.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @email }
    end
  end

  # GET /emails/1/edit
  def edit
    @email = Email.find(params[:id])
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = @user.emails.new(params[:email])

    respond_to do |format|
      if @email.save
        format.html { redirect_to [@game, @user, @email], notice: 'Email was successfully created.' }
        format.json { render json: [@game, @user, @email], status: :created, location: [@game, @user, @email] }
      else
        format.html { render action: "new" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emails/1
  # PUT /emails/1.json
  def update
    @email = @user.emails.find(params[:id])

    respond_to do |format|
      if @email.update_attributes(params[:email])
        format.html { redirect_to [@game, @user, @email], notice: 'Email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email = Email.find(params[:id])
    @email.destroy

    respond_to do |format|
      format.html { redirect_to game_user_emails_url }
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
