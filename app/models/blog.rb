class Blog < ApplicationRecord
  belongs_to :blogger, inverse_of: :blogs
  has_many :taggings
  has_many :tags, through: :taggings
  self.per_page = 10

  def self.store_post(post, bloggers_data)
    blogger = Blogger.where(user_id: post['creatorId']).first_or_initialize
    blogger = blogger.store(bloggers_data) if blogger.new_record?
    blog = blogger.blogs.where(slug: post['uniqueSlug']).first_or_initialize
    blog.store(post) if blog.new_record?
  end

  def store(post)
    url = url(blogger.user_id, slug)
    @document = Nokogiri::HTML(open(url))
    update_attributes(
      title: fetch_title,
      details: fetch_detail,
      content: fetch_content,
      link: url
    )
    generate_taggings(post['virtuals']['tags'])
  end

  def url(blogger, slug)
    "#{Scrape::DOMAIN}/#{blogger}/#{slug}"
  end

  def fetch_title
    @document.css('.graf--title').text
  end

  def fetch_detail
    "#{@document.css('.js-testPostMetaInlineSupplemental').text} - #{@document.css('.js-testPostMetaInlineSupplemental span.readingTime').first['title']}"
  end

  def fetch_content
    @document.css('.js-notesSource .section-content').to_s
  end

  def generate_taggings(tags)
    tags.each do |tag|
      tag = Tag.where(tag.slice('slug', 'name')).first_or_create
      taggings.create(tag: tag)
    end
  end

end
