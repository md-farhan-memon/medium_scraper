class User < ApplicationRecord
  has_secure_password

  def update_search_history(tag)
    unless (history = search_history.to_s.split(',')).include?(tag)
      history << tag
      update_attribute(:search_history, history.join(','))
    end
  end

end
