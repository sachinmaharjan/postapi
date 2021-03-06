require 'rails_helper'

describe Post do
  def new_post(attributes = {})
    attributes[:author] ||= 'some author'
    attributes[:title] ||= 'some title'
    attributes[:content] ||= 'some content'
    attributes[:post_id] ||= 1
    Post.new(attributes)
  end

  it "should create a new instance of a post given valid attributes" do
    @post_attr =  FactoryGirl.attributes_for(:post)
    Post.create!(@post_attr)
  end


  it "should require title" do
    post = Post.new(:title => "")
    expect(post.valid?).to eq(false)
    expect(post.errors[:title]).to eq(["can't be blank"])
  end

  it "should require author" do
    post = Post.new(:author => "")
    expect(post.valid?).to eq(false)
    expect(post.errors[:author]).to eq(["can't be blank"])
  end

  it "should require content" do
    post = Post.new(:content => "")
    expect(post.valid?).to eq(false)
    expect(post.errors[:content]).to eq(["can't be blank"])
  end

  it "should require user_id" do
    post = Post.new(:user_id => "")
    expect(post.valid?).to eq(false)
    expect(post.errors[:user_id]).to eq(["can't be blank"])
  end

  it "has many images" do
    @post = FactoryGirl.create :post
    @img1 = FactoryGirl.create :image
    @img2 = FactoryGirl.create :image
    expect(@post.image.count).to eq(2)
  end

  it "has many comments" do
    @post = FactoryGirl.create :post
    @comment1 = FactoryGirl.create :comment
    @comment2 = FactoryGirl.create :comment
    expect(@post.comments.count).to eq(2)
  end

  it "belongs to user" do
    @user = FactoryGirl.create :user
    @post = FactoryGirl.create :post
    expect(@post.user).to eq(@user)
  end

  it "orders desc" do
    @post = FactoryGirl.create :post
    @post1 = FactoryGirl.create :post
    @post3 = FactoryGirl.create :post
    expect(Post.first.id).to eq(@post3.id)
  end
end
