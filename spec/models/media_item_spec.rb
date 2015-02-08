require 'rails_helper'

describe MediaItem, type: :model do
  it { should have_many :images }
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should allow_value('http://foo.com', 'http://bar.com/baz').for(:website_url) }
  it { should allow_value('http://foo.com/example.flv', 'http://bar.com/baz/example2.flv').for(:video_url) }
  it { should_not allow_value('foo', 'bar').for(:website_url) }
  it { should_not allow_value('foo', 'bar').for(:video_url) }

  describe '.search' do
    let(:title) { Faker::Lorem.word }
    let(:first_item) { FactoryGirl.create :media_item, title: title }
    let(:second_item) { FactoryGirl.create :media_item }

    it { expect(MediaItem.search(title[0..3])).to include(first_item) }
    it { expect(MediaItem.search(title[0..3])).not_to include(second_item) }
  end
end
