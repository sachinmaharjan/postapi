require 'rails_helper'

RSpec.describe ReportController, type: :controller do

  describe "GET #activities_by_city" do
    it "should be successful" do
      get :activities_by_city
      expect(response.status).to eq 200
    end

    it "should have data" do
      @user = FactoryGirl.create :user
      @post = FactoryGirl.create :post
      @comment = FactoryGirl.create :comment
      get :activities_by_city
      body = JSON.parse(response.body)
      expect(body.count).to eq 1
    end
  end

end
