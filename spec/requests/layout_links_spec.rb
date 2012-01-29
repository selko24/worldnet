require 'spec_helper'

describe "LayoutLinks" do
 
 it "should have a Hom page at '/" do
   get '/'
   response.should have_selector('title', :content => "Domov")
 end
 
 it "should have a Contact page at '/contact" do
   get '/contact'
   response.should have_selector('title', :content => "Kontakt")
 end
 
  it "should have a About page at '/about" do
   get '/about'
   response.should have_selector('title', :content => "O nas")
 end
 
  it "should have a Registration page at '/registration" do
   get '/registration'
   response.should have_selector('title', :content => "Registracija")
 end
  it "should have the right links on the layout" do
  visit root_path
  response.should have_selector('title', :content => "Domov")
  click_link "O nas"
  response.should have_selector('title', :content => "O nas")
   click_link "Kontakt"
  response.should have_selector('title', :content => "Kontakt")
  click_link "Domov"
  response.should have_selector('title', :content => "Domov")
  click_link "Registriraj se!"
  response.should have_selector('title', :content => "Registriraj se!")
 end
end
