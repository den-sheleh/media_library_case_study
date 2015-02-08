require 'rails_helper'

describe User, type: :model do
  it { should have_many :media_items }

  describe :share do
    let(:user) { FactoryGirl.create :user }

    it "should make user's profile public" do
      user.share!
      expect(user.is_public).to be true
    end
  end

  describe :hide do
    let(:user) { FactoryGirl.create :user, is_public: true }

    it "should make user's profile private" do
      user.hide!
      expect(user.is_public).to be_falsy
    end
  end
end
