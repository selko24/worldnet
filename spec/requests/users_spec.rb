require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failure" do
      it "should not make a new user" do
        lambda do
        visit signup_path
        fill_in "Ime", :with => ""
        fill_in "e-pošta", :with => ""
        fill_in "Geslo", :with => ""
        fill_in "Ponovi geslo", :with => ""
        click_button
        response.should render_template('user/new')
         response.should have_selector('div#error_explanation')
         end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Ime", :with => "Example User"
        fill_in "e-pošta", :with => "user@example.com"
        fill_in "Geslo", :with => "foobar"
        fill_in "Ponovi geslo", :with => "foobar"
        click_button
        response.should have_selector('div.flash.success',
                                      :content => "Dobrodošli")
       response.should render_template('users/show')
       end.should change(User, :count).by(1)
        end
      end
    end
    
  end
end
