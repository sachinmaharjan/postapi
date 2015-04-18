require 'rails_helper'

describe User do
  it "should require a name" do
    expect(User.new.error_on(:name).size).to eq(1)
  end
end
