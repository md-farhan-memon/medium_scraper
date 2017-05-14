class Scrape < ApplicationRecord
  DOMAIN = 'https://medium.com'
  class << self

    def pull_data(tag, next_page)
      fetch(url(tag, next_page), tag)
    end

    private

    def url(tag, next_page)
      web_url = if next_page && (tag = Tag.find_by_slug(tag)).present? && (next_page = JSON.parse(tag.next_page)).present?
                  "#{DOMAIN}#{next_page['path']}?limit=#{next_page['next']['limit']}&to=#{next_page['next']['to']}"
                else
                  "#{DOMAIN}/topic/#{tag}"
                end
      for_api(web_url)
    end

    def for_api(web_url)
      web_url.include?('?') ? "#{web_url}&format=json" : "#{web_url}?format=json"
    end

    def fetch(url, tag)
      response = HTTParty.get(url)
      data = JSON.parse Nokogiri::HTML(response.body).text.gsub("])}while(1);",'')
      if data['success']
        store_data(data['payload'], tag)
        data['success']
      elsif !data['success']
        data['success']
      end
    end

    def store_data(data, tag)
      bloggers_data = data['references']['User']
      data['references']['Post'].each do |post|
        Blog.store_post(post.last, bloggers_data)
      end
      Tag.find_by_slug(tag).update_column(:next_page, data['paging'].except('previous').to_json)
    end

  end
end
