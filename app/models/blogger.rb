class Blogger < ApplicationRecord
  has_many :blogs, inverse_of: :blogger

  def store(bloggers_data)
    data = find_blogger(bloggers_data)
    update_attributes(data.slice('name', 'username', 'bio'))
    self
  end

  private

  def find_blogger(bloggers_data)
    bloggers_data.detect { |blogger| blogger.first == user_id }.last
  end
end
