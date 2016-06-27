class Post < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  extend FriendlyId

  friendly_id :title, use: :slugged

  acts_as_taggable

  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: { minimum: 10, maximum: 255 }
  validates :body, presence: true

  scope :latest_posts, -> { order('created_at desc') }

  settings index: { number_of_shards: 1 }

  mapping do
    indexes :id, index: :not_analyzed
    indexes :title
  end

  def as_indexed_json(options = {})
    self.as_json(only: [:title, :body],
      include: {
        user: { only: [:email] },
        tags: { only: [:name] }
    })
  end

  after_save :clear_cache

  def self.latest_posts_cached
    posts = $redis.get('posts')
    if posts.nil?
      posts = Post.latest_posts.decorate.map do |post|
        p = JSON.load(post.to_json)
        p['tags'] = post.tags
        p
      end

      posts = posts.to_json
      $redis.set('posts', posts)
      $redis.expire('posts', 3.hour.to_i)
    end
    @result = JSON.load posts
  end

  private

  def clear_cache
    $redis.del('posts')
  end
end

Post.import
