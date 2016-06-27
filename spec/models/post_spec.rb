require 'rails_helper'

describe Post do
  let(:post) { FactoryGirl.create :post }

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }

    it 'title length should have at least 10 characters long' do
      post.title = 'A' * 9
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include(/is too short/)
    end

    it 'title length should be 255 characters max' do
      post.title = 'A' * 256
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include(/is too long/)
    end
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should have_many :comments }
  end

  describe '#latest_posts' do
    it 'order by created_at desc' do
      x = FactoryGirl.create(:post, title: 'First Title', body: 'lorem')
      y = FactoryGirl.create(:post, title: 'Second Title', body: 'lorem')
      z = FactoryGirl.create(:post, title: 'Third Title', body: 'lorem')
      expect(Post.latest_posts).to eq([z.decorate,
                                       y.decorate,
                                       x.decorate])
    end
  end

  describe '#latest_posts_cached' do
    it 'order cached posts by created_at desc' do
      x = FactoryGirl.create(:post, title: 'First Title', body: 'lorem')
      y = FactoryGirl.create(:post, title: 'Second Title', body: 'lorem')
      z = FactoryGirl.create(:post, title: 'Third Title', body: 'lorem')

      decorated_posts = [z.decorate, y.decorate, x.decorate]

      # cached posts must store decorated tags
      posts = decorated_posts.map do |post|
        p = JSON.load(post.to_json)
        p['tags'] = post.tags
        p
      end

      expect(Post.latest_posts_cached).to eq(posts)
    end
  end
end
