class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all(:order => "email")
  end

def new
  @user = User.new
end

def create
  # extract the admin flag, as we cannot mass-assign this param when
  # calling new (it is not attr_accessible)
  admin =  params[:user].delete("admin") == "1"
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

end
