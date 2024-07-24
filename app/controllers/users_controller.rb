class UsersController < ApplicationController


  before_action :find_user, only: [:show, :destroy, :edit, :update]
  def index
    @pagy, @users = pagy(User.all)
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'User deleted successfully'
    else
      flash[:notice] = @user.errors.full_messages.join(", ")
    end
    redirect_to users_path
  end

  def edit
  end

  def new
    @user = User.new
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User updated successfully'
      redirect_to user_path(@user)
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {render turbo_stream: turbo_stream.replace('users_feedback', partial: 'users_feedback', locals: { user: @user })}
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User created successfully'
      redirect_to user_path(@user)
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream {render turbo_stream: turbo_stream.replace('users_feedback', partial: 'users_feedback', locals: { user: @user })}
      end
    end
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:notice] = "User not found"
      redirect_to users_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :role)
  end
end
