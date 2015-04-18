require 'rails_helper'

describe MainController do

  describe "#index" do
    it "should be successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

end
