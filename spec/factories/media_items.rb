FactoryGirl.define do
  factory :media_item do
    title { Faker::Lorem.word }
    association :user, factory: :user
    website_url { Faker::Internet.url }
    video_url { Faker::Internet.url }
  end
end
