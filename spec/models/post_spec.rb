require 'rails_helper'

describe Post do
  let(:post) { FactoryGirl.create :post }

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }

    it 'is invalid' do
      post.title = nil
      post.body = nil
      expect(post).to_not be_valid
    end

    it 'requires title' do
      post.title = nil
      expect(post).to_not be_valid
      expect(post.errors[:title]).not_to be_blank
    end

    it 'requires body' do
      post.body = nil
      expect(post).to_not be_valid
      expect(post.errors[:body]).not_to be_blank
    end

    it 'title length should have at least 10 characters long' do
      post.title = 'TITLE'
      expect(post).to_not be_valid
      expect(post.errors.size).to eq(1)
    end

    it 'title length should be 255 characters max' do
      post.title = 'A' * 256
      expect(post).to_not be_valid
      expect(post.errors.size).to eq(1)
    end
  end

  describe 'associations' do
    it { should belong_to :user }
  end

  describe '#latest_posts' do
    it 'order by created_at desc' do
      FactoryGirl.create(:post, title: 'First Title', body: 'lorem')
      x = FactoryGirl.create(:post, title: 'Second Title', body: 'lorem')
      expect(Post.latest_posts.first).to eq(x)
    end
  end
end
