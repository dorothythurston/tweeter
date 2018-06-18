FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password_digest 'password'
  end
  factory :tweet do
    body "hello i am a tweet"
    association :user
  end
end
