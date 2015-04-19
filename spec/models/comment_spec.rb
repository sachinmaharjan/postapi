require 'rails_helper'

describe Comment do
  def new_image(attributes = {})
    attributes[:message] ||= 'some message'
    attributes[:post_id] ||= 1
    attributes[:user_id] ||= 1
    Post.new(attributes)
  end

  it "should create a new instance of a image given valid attributes" do
    @comment_attr =  FactoryGirl.attributes_for(:comment)
    Comment.create!(@comment_attr)
  end


  it "should require message" do
    comment = Comment.new(:message => "")
    expect(comment.valid?).to eq(false)
    expect(comment.errors[:message]).to eq(["can't be blank"])
  end


  it "should require user_id" do
    comment = Comment.new(:user_id => "")
    expect(comment.valid?).to eq(false)
    expect(comment.errors[:user_id]).to eq(["can't be blank"])
  end

  it "should require post_id" do
    comment = Comment.new(:post_id => "")
    expect(comment.valid?).to eq(false)
    expect(comment.errors[:post_id]).to eq(["can't be blank"])
  end


  it "belongs to post" do
    @post = FactoryGirl.create :post
    @comment = FactoryGirl.create :comment
    expect(@comment.post).to eq(@post)
  end

  it "orders desc" do
    @comment1 = FactoryGirl.create :comment
    @comment2 = FactoryGirl.create :comment
    expect(Comment.first.id).to eq(@comment2.id)
  end
end
