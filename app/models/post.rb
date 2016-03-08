class Post < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  acts_as_taggable

  belongs_to :user

  validates :title, presence: true, length: { minimum: 10, maximum: 255 }
  validates :body, presence: true

  scope :latest_posts, -> { order('created_at desc') }
end
