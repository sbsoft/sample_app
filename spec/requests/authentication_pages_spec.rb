require 'spec_helper'

describe "Authentication" do
  subject { page }
  before  { visit signin_path }
  
  describe "signin page" do
    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title', tet: 'Sign in') }
  end
  
  describe "signin" do
    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do # Catch flash persistence bug
        before { click_link "Home" }
        it { should_not have_error_message('') }
      end
    
    end
    
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }
      
      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      # it { should_not have_link('Sign in', href: signin_path) }  tutorial version
      it { should_not have_link('Sign in') }  # My version
    end
  end
end
