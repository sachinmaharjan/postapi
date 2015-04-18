require 'rails_helper'

describe ImagesController do

  describe "#destroy" do
    it "should be successful" do
      FactoryGirl.create :image
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

  describe "#create" do

    it "creates an image " do
      post :create, image: { post_id: 1, path: "some_path" }
      expect(response.status).to eq 201
      expect(Image.first.post_id).to eq 1
      expect(Image.first.path).to eq "some_path"
    end

    it "should return unprocessable_entity for errors" do
      post :create, image: { post_id: 1 }
      expect(response.status).to eq 422
    end

    it "should have error on path" do
      post :create, image: { post_id: 1}
      body = JSON.parse(response.body)
      expect(body["path"]).to eq ["can't be blank"]
    end

    it "should have error on post_id" do
      post :create, image: { path: "some_path"}
      body = JSON.parse(response.body)
      expect(body["post_id"]).to eq ["can't be blank"]
    end

  end

end
