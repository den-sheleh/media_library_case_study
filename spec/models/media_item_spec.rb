require 'rails_helper'

describe MediaItem, type: :model do
  it { should have_many :images }
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should allow_value('http://foo.com', 'http://bar.com/baz').for(:website_url) }
  it { should allow_value('http://foo.com/example.flv', 'http://bar.com/baz/example2.flv').for(:video_url) }
  it { should_not allow_value('foo', 'bar').for(:website_url) }
  it { should_not allow_value('foo', 'bar').for(:video_url) }
end
