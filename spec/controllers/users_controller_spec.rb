require 'rails_helper'

describe UsersController do

  describe "#show" do
    before(:each) do
      @user = FactoryGirl.create :user
    end

    it "should be successful" do
      get :show, id: @user.id
      expect(response.status).to eq 200
    end

    it "should return 404" do
      get :show, id: 33
      expect(response.status).to eq 404
      expect(response.body).to eq "Record not found!"
    end

    it "should have correct name " do
      get :show, id: @user.id
      body = JSON.parse(response.body)
      expect(body["name"]).to eq "John Doe"
    end

    it "should have correct city " do
      get :show, id: @user.id
      body = JSON.parse(response.body)
      expect(body["city"]).to eq "San Francisco"
    end

  end

  describe "#create" do
    it "creates a user " do
      post :create, user: { city: "Honolulu", name: "Kelly Slater" }
      expect(response.status).to eq 201
      expect(User.first.name).to eq "Kelly Slater"
      expect(User.first.city).to eq "Honolulu"
    end

    it "should return unprocessable_entity for errors" do
      post :create, user: { name: "Kelly Slater" }
      expect(response.status).to eq 422
    end

    it "should have error on city" do
      post :create, user: { name: "Kelly Slater"}
      body = JSON.parse(response.body)
      expect(body["city"]).to eq ["can't be blank"]
    end

    it "should have error on name" do
      post :create, user: { city: "San Francisco"}
      body = JSON.parse(response.body)
      expect(body["name"]).to eq ["can't be blank"]
    end

  end

end
