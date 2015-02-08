require 'rails_helper'

describe Image, type: :model do
  it { should belong_to(:media_item) }
  it { should validate_presence_of(:media_item) }
end
