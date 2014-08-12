class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :finish_signup, :profile, :choose_avatar, :destroy]
  # GET /users/:id.:format
  def show
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to :root, notice: 'Your profile was successfully updated.'
      else
        flash[:error] = "That email already exists. If this is you, please log in with another service and try reconnecting this service."
        @show_errors = true
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def profile
    # authorize! :update, @user
    if request.patch? && params[:user]
      if @user.update(profile_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to :root, notice: 'Your profile was successfully updated.'
      else
        flash[:error] = "That email already exists. If this is you, please log in with another service and try reconnecting this service."
        @show_errors = true
      end
    else
      @user = User.find(current_user.id)
    end
  end

  # POST /users/:id/choose_avatar
  def choose_avatar
    @user.set_avatar_to_identity(params[:provider])
    redirect_to :profile, notice: 'Your profile image was successfully changed.'
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def map
    @users = User.with_location
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.json({:id => user.id })
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      accessible = [ :name, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

    def profile_params
      accessible = [ :name, :email, :met_when, :met_how, :location ]
      params.require(:user).permit(accessible)
    end
end
