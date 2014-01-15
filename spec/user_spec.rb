require_relative "./spec_helper.rb"

describe "User" do
  
  before { @user= User.new }

  describe '#initialize' do
    it "should create a new instance of user" do
      expect(@user).to be_an_instance_of(User)
    end
  end
end