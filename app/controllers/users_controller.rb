class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  require 'digest/md5'
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

=begin
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
=end

    def login
      render :layout => 'login_user'
    end

    def check_user
      @username = params[:user][:username]
      @password = Digest::MD5.hexdigest("#{params[:user][:password]}")
      session[:user_logged_in] = params[:user][:username]
      @user = User.where(username: @username).take
      @password_db = User.where(password: @password).take

      if @user.username == @username && @password_db.password == @password
        redirect_to  :action=> :show_index
      end

    end

    def show_index
      #@user_logged_in[:username] =
      logger.info "USER #{session[:user_logged_in]}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :username)
    end
end
