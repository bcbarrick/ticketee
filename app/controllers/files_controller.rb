class FilesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @ticket = Ticket.new
    asset = @ticket.assets.build
    render :partial => "files/form",
    :locals => { :number => params[:number].to_i }
  end

  def show
    asset = Asset.find(params[:id])
    if current_user.admin || can?(:view, asset.ticket.project)
      send_file asset.asset.path, :filename => asset.asset_file_name, :content_type => asset.asset_content_type
    else
      flash[:alert] = "The asset you were looking for could not be found."
      redirect_to root_path
    end
  end
end
