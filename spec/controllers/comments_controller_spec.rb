require 'rails_helper'

describe CommentsController do

  describe "#list" do

    it "should be successful" do
      @comment1 = FactoryGirl.create :comment
      @comment2 = FactoryGirl.create :comment
      get :list, post_id: @comment1.post_id
      expect(response.status).to eq 200
    end

    it "should return 404" do
      get :list
      expect(response.status).to eq 200
      expect(response.body).to eq "[\n\n]"
    end

    it "should have correct number of records " do
      @comment1 = FactoryGirl.create :comment
      @comment2 = FactoryGirl.create :comment
      get :list, post_id: @comment1.post_id
      body = JSON.parse(response.body)
      expect(body.count).to eq 2
    end

  end


  describe "#create" do
    it "creates a comment " do
      post :create, comment: { post_id: 1, message: "Kelly Slater Surfs", user_id: 1 }
      expect(response.status).to eq 201
      expect(Comment.first.message).to eq "Kelly Slater Surfs"
    end

    it "creates a comment for that has paent " do
      @parent_comment = FactoryGirl.create :comment
      post :create, comment: { post_id: 1, message: "Second comment", user_id: 1, parent_id: @parent_comment.id }
      expect(response.status).to eq 201
      expect(Comment.first.message).to eq "Second comment"
      expect(Comment.first.parent_id).to eq @parent_comment.id
    end

    it "should return unprocessable_entity for errors" do
      post :create, comment: { post_id: 1, message: "" }
      expect(response.status).to eq 422
    end

    it "should have errors" do
      post :create, comment: { post_id: 1, message: "" }
      body = JSON.parse(response.body)
      expect(body["message"]).to eq ["can't be blank"]
      expect(body["user_id"]).to eq ["can't be blank"]
    end

  end


  describe "#destroy" do
    it "should be successful" do
      FactoryGirl.create :comment
      delete :destroy, id: 1
      expect(response.status).to eq 200
      expect(response.body).to eq "Successfully deleted"
    end

    it "should decrease the comment" do
      FactoryGirl.create :comment
      expect(Comment.count).to eq 1
      delete :destroy, id: 1
      expect(Comment.count).to eq 0
    end

    it "should return 404" do
      delete :destroy, id: 33
      expect(response.status).to eq 404
      expect(response.body).to eq "Record not found!"
    end
  end

end
