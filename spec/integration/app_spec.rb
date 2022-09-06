require "spec_helper"
require_relative '../../app'
require "rack/test"

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
end
