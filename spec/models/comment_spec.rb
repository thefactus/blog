require 'rails_helper'

describe Comment do
  describe 'validations' do
    it { should validate_presence_of :body }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :post }
  end
end
