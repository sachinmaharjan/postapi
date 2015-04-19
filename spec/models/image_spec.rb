require 'rails_helper'

describe Image do
  def new_image(attributes = {})
    attributes[:path] ||= 'some path'
    attributes[:post_id] ||= 1
    Post.new(attributes)
  end

  it "should create a new instance of a image given valid attributes" do
    @image_attr =  FactoryGirl.attributes_for(:image)
    Image.create!(@image_attr)
  end


  it "should require path" do
    img = Image.new(:path => "")
    expect(img.valid?).to eq(false)
    expect(img.errors[:path]).to eq(["can't be blank"])
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
