class BlogsController < ApplicationController

  def index
    @blogs = Blog.order('created_at desc').page(params[:page])
  end

  def latest
    @blogs = Blog.order('created_at desc').limit(10)
  end

end