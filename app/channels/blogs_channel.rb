class BlogsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "blogs_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
