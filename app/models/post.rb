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

  mapping do
    indexes :id, index: :not_analyzed
    indexes :title
  end

  def as_indexed_json(options = {})
    self.as_json(only: [:id, :title, :body],
      include: {
        user: { only: [:email] },
        tags: { only: [:name] }
    })
  end
end

Post.import
