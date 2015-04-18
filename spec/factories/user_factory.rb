require 'faker'

FactoryGirl.define do
  factory :user do
    name                 "John Doe"
    city                 "San Francisco"
  end
end
