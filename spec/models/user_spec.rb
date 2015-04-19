require 'rails_helper'

describe User do
  def new_user(attributes = {})
    attributes[:name] ||= 'some name'
    attributes[:city] ||= 'some city'
    User.new(attributes)
  end

  it "should create a new instance of a user given valid attributes" do
    @user_attr =  FactoryGirl.attributes_for(:user)
    User.create!(@user_attr)
  end


  it "should require name" do
    user = User.new(:name => "")
    expect(user.valid?).to eq(false)
    expect(user.errors[:name]).to eq(["can't be blank"])
  end

  it "should require city" do
    user = User.new(:city => "")
    expect(user.valid?).to eq(false)
    expect(user.errors[:city]).to eq(["can't be blank"])
  end

  it "has_many posts" do
    @user = FactoryGirl.create :user
    @post1 = FactoryGirl.create :post
    @post2 = FactoryGirl.create :post
    expect(@user.post.count).to eq(2)
  end
end
