class BloggersController < ApplicationController

  def show
    @blogs = Blog.includes(:blogger).where(blogger_id: params[:id]).page(params[:page])
  end

end