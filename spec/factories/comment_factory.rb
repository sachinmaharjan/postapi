require 'faker'

FactoryGirl.define do
  factory :comment do
    post_id                 1
    message                 "This is comment."
    user_id                 1
  end
end
