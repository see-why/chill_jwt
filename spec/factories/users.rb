FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password_digest { "MyString" }
    password_confirmation { "MyString" }
  end
end
