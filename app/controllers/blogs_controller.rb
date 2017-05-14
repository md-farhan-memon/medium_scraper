class BlogsController < ApplicationController

  def index
    @blogs = Blog.includes(:blogger).order('created_at desc').page(params[:page])
  end

  def latest
    @blogs = Blog.includes(:blogger).order('created_at desc').limit(10)
  end

  def show
    @blog = Blog.includes(:blogger).find_by_id(params[:id])
  end

end