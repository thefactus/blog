require 'rails_helper'

feature "User manages posts" do
  let(:user) { FactoryGirl.create :user }

  before(:each) do
    login_as(user, :scope => :user)
  end

  scenario 'creates a post' do
    visit '/admin'
    click_link 'Posts'
    click_link 'New Post'
    fill_in 'Title', :with => 'Lorem Ipsum'
    fill_in 'Body', :with => 'Something'
    click_button 'Create Post'
    expect(page).to have_content('Post was successfully created!')
  end

  scenario 'edit a post' do
    post = FactoryGirl.create(:post, title: 'Lorem Ipsum', body: 'Something', user: user)
    visit edit_post_url(post)
    fill_in 'Title', :with => 'New post title'
    fill_in 'Body', :with => 'Something new'
    click_button 'Update Post'
    expect(page).to have_content('Post was successfully updated!')
  end
end
