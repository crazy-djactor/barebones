require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    it 'has a valid content' do
      expect(build(:user)).to be_valid
    end

    it 'is invalid without a first_name and email' do
      expect(build(:user, first_name: nil, email: nil)).to_not be_valid
    end
  end
end
