class BlogsChannel < ApplicationCable::Channel  
  def subscribed
    stream_from 'blogs'
  end
end