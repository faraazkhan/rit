require 'spec_helper'

describe User do
  before do
    @valid_attributes = {
      :email => 'tester@test.com', 
      :username => 'Tester Khan', 
      :password => 'password'
    }
  end
  context "Relationships" do
    it { should have_many(:registrations) }
    it { should have_many(:courses).through(:registrations) }
  end
  
  context "Registration" do
    it "should allow users to register for a course" do  
      @user = User.make(@valid_attributes)
      # @course = Course.make
      #     lambda   {@user.register_for(@course)}.should change(@users, :courses).from([]).to([@course])
    end
  end
  context "Authentication" do
    it "should find users by their emails or their usernames" do
      email_warden_conditions = {"login"=>"test0@rit.com"}
      username_warden_conditions = {"login" => "Tester Khan"}
      u = User.make(@valid_attributes)
      User.find_first_by_auth_conditions(email_warden_conditions).should == u 
      User.find_first_by_auth_conditions(username_warden_conditions).should == u 

    end

  end
end

