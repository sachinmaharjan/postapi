require 'rails_helper'

describe PostsController do

  describe "#list" do

    it "should be successful" do
      @post1 = FactoryGirl.create :post
      @post2 = FactoryGirl.create :post
      get :list
      expect(response.status).to eq 200
    end

    it "should return 404" do
      get :list
      expect(response.status).to eq 200
      expect(response.body).to eq "[\n\n]"
    end

    it "should have correct number of records " do
      @post1 = FactoryGirl.create :post
      @post2 = FactoryGirl.create :post
      get :list
      body = JSON.parse(response.body)
      expect(body.count).to eq 2
    end

  end

  describe "#create" do
    it "creates a post " do
      post :create, post: { author: "Some author", title: "Kelly Slater Surfs", content: "the number one surfer", user_id: 1 }
      expect(response.status).to eq 200
      expect(Post.first.title).to eq "Kelly Slater Surfs"
      expect(Post.first.author).to eq "Some author"
    end

    it "should return unprocessable_entity for errors" do
      post :create, post: { title: "Kelly Slater" }
      expect(response.status).to eq 422
    end

    it "should have errors" do
      post :create, post: {title: ""}
      body = JSON.parse(response.body)
      expect(body["title"]).to eq ["can't be blank"]
      expect(body["author"]).to eq ["can't be blank"]
      expect(body["content"]).to eq ["can't be blank"]
      expect(body["user_id"]).to eq ["can't be blank"]
    end

  end

  describe "#update" do

    before(:each) do
      @post = FactoryGirl.create :post
    end

    let(:attr) do
      { title: 'other title' }
    end

    it "updates a post " do
      put :update, id: 1, post: attr
      expect(response.status).to eq 200
      expect(Post.find(@post.id).title).to eq "other title"
    end

    it "should return unprocessable_entity for errors" do
      put :update, id: 1, post: {title: "" }
      expect(response.status).to eq 422
    end

    it "should return 404" do
      put :update, id: 33
      expect(response.status).to eq 404
      expect(response.body).to eq "Record not found!"
    end


    it "should have error on title" do
      put :update, id: 1, post: { title: '' }
      body = JSON.parse(response.body)
      expect(body["title"]).to eq ["can't be blank"]
    end

  end

  describe "#destroy" do
    it "should be successful" do
      FactoryGirl.create :post
      delete :destroy, id: 1
      expect(response.status).to eq 200
      expect(response.body).to eq "Successfully deleted"
    end

    it "should return 404" do
      delete :destroy, id: 33
      expect(response.status).to eq 404
      expect(response.body).to eq "Record not found!"
    end
  end

  describe "#show" do
    before(:each) do
      @post = FactoryGirl.create :post
    end

    it "should be successful" do
      get :show, id: @post.id
      expect(response.status).to eq 200
    end

    it "should have correct data" do
      get :show, id: @post.id
      body = JSON.parse(response.body)
      expect(body["author"]).to eq "John Smith"
      expect(body["title"]).to eq "What a beautiful day"
      expect(body["content"]).to eq "Today is a lovely sunny day."
      expect(body["user_id"]).to eq 1
    end

    it "should return 404" do
      get :show, id: 33
      expect(response.status).to eq 404
      expect(response.body).to eq "Record not found!"
    end

  end

end
