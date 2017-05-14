class ScrapesController < ApplicationController
  before_action :authorize

  def pull
    if Scrape.pull_data(params[:query], params[:latest] == 'on')
      current_user.update_search_history(params[:query])
      flash[:notice] = "Blogs fetched succesfully!"
      redirect_to blogs_path and return
    else
      flash[:alert] = "Please check the tag and try again.."
      redirect_to blogs_path and return
    end
  rescue StandardError => e
    flash[:alert] = "Error: #{e.message}"
    redirect_to blogs_path and return
  end

end
