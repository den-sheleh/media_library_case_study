FactoryGirl.define do
  factory :image do
    association :media_item, factory: :media_item
    file { fixture_file_upload(Rails.root.join('spec', 'factories', 'support', 'test.png'), 'image/png') }
  end
end
