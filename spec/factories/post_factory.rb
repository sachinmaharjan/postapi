require 'faker'

FactoryGirl.define do
  factory :post do
    author                "John Smith"
    title                 "What a beautiful day"
    content               "Today is a lovely sunny day."
    user_id               1
  end
end
