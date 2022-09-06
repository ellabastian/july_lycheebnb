require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
      # This is so we can use rack-test helper methods.
      include Rack::Test::Methods
    
      # We need to declare the `app` value by instantiating the Application
      # class so our tests work.
      let(:app) { Application.new }

context 'GET /' do
      it "should return the HTML home page with sign-up/sign-in" do
            response = get('/')

            expect(response.status).to eq(200)
            expect(response.body).to include "<h1> Welcome to Lychee MakersBnB </h1>"

      end 
end 

context 'GET /signin' do
      it "should return the HTML page with sign-in" do
            response = get('/signin')

            expect(response.status).to eq(200)
            expect(response.body).to include "<h1> Please, sign in below </h1>"

      end 
end 

context 'POST /signup' do
      it "should check the email address doesn't already exist(new email address given)" do
            response = post('/signup', name: 'newuser', email: 'newuser@newuser.com', password: 'password1')


            expect(response.status).to eq(200)
            expect(response.body).to include '<p> Below you will find a selection of spaces you can book.'

            repo = UserRepository.new
            all_users = repo.all
            expect(all_users.last.name).to eq 'newuser'

      end 

      it "should check the email address doesn't already exist(existing email address given" do
            response = post('/signup', name: 'newuser', email: 'test1@email.com', password: 'password1')


            expect(response.status).to eq(200)
            expect(response.body).to include 'Email already registered. Please log in'

      end 
end 


context 'POST /signup' do
      it "should add a valid user and return the main spaces HTML page" do
            response = post('/signup', name: 'newuser', email: 'newuser@newuser.com', password: 'password1')


            expect(response.status).to eq(200)
            expect(response.body).to include '<p> Below you will find a selection of spaces you can book.'

            repo = UserRepository.new
            all_users = repo.all
            expect(all_users.last.name).to eq 'newuser'

      end 
end 
end
