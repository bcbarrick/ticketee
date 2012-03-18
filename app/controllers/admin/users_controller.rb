class Admin::UsersController < Admin::BaseController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  def index
    @users = User.all(:order => "email")
  end

  def show
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    @user.admin = set_admin
    if @user.update_attributes(params[:user])
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render :action => "edit"
    end
  end

def new
  @user = User.new
end

def create
  # extract the admin flag, as we cannot mass-assign this param when
  # calling new (it is not attr_accessible)
  admin = set_admin
  @user = User.new(params[:user])
  @user.admin = admin
  if @user.save
    flash[:notice] = "User has been created."
    redirect_to admin_users_path
  else
    flash[:alert] = "User has not been created."
    render :action => "new"
  end
end

  private
    def set_admin
      admin = params[:user].delete("admin") == "1"
    end

    def find_user
      @user = User.find(params[:id])
    end
end
