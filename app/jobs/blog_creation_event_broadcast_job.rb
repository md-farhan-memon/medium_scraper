class BlogCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(blog)
    ActionCable.server.broadcast('blogs_channel', {
      description: render_description(blog)
    })
  end

  private

  def render_description(blog)
    # In Rails 5, renderer has been made public so that we can use
    # ApplicationController.renderer to render a partial
    ApplicationController.renderer.render(
      partial: 'blogs/listing', locals: { blog: blog })
  end
end
