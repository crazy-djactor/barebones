require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = create(:user)
  end

  describe Post do
    it 'has a valid content' do
      expect(build(:post, user: @user)).to be_valid
    end

    it 'is invalid without a title and body' do
      expect(build(:post, title: nil, body: nil, user: @user)).to_not be_valid
    end
  end
end
