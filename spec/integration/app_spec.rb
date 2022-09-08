require "spec_helper"
require_relative '../../app'
require "rack/test"

describe Application do
      include Rack::Test::Methods
      let(:app) { Application.new }


context 'GET /' do
      it "should return the HTML home page with sign-up/sign-in" do
            response = get('/')

            expect(response.status).to eq(200)
            expect(response.body).to include "<h2> Welcome to Lychee MakersBnB </h2>"
      end 
end 

context 'GET /login' do
      it "should return the HTML page with sign-in" do
            response = get('/login')

            expect(response.status).to eq(200)
            expect(response.body).to include "<h2>Please, sign in below</h2>"
      end 
end 

context 'GET /' do
            it 'returns HTML form for user to fill out' do
            response = get('/')
            expect(response.status).to eq(200)
            expect(response.body).to include '<form class="box" action="/signup" method="post">'
      end
end

context 'POST /signup' do
      it "redirects user to login page if email address exists" do
            response = post('/signup', name: 'Testing', email: 'Mike@email.com', password: 'Password11')
            expect(response.status).to eq(200)
            expect(response.body).to include '<h2>Please, sign in below</h2>'
            end 

      it "creates a new user if information is valid" do
            response = post("/signup", name: 'George', email: 'George@gmail.com', password: 'George11')
            expect(response.status).to eq(302)

            response = get('/spaces')
            expect(response.body).to include '<h2> Book a Space </h2>'
            end 
      end

context "GET /spaces" do
      it "returns a list of all spaces" do
            response = get("/spaces")
            expect(response.status).to eq (200)
            expect(response.body).to include ('<h2> Choose a date to book </h2>')
      end
end

context "GET /space/new" do
            it "returns a new space page" do
                  response = get("/space/new")
                  expect(response.status).to eq 200
                  expect(response.body).to include "<h1>Create a space</h1>"
            end
      end

context "GET /confirmation" do
      it "returns the confirmations page" do
            response = get('/request_form/2')
            expect(response.status).to eq 200
            expect(response.body).to include "<h3 id='request_from_h3'>From: David@email.com</h3>"
            end
      end

context "post /signup" do
      it "fails if the name field is empty/nil" do
      response = post('/signup', name: nil , email: 'Mike@email.com', password: 'Password11')
      expect(response.status).to eq (400)
      end
end

context "post /login" do
      it "logs user in if their information exists in the database" do
      response = post('/login', email: 'David@email.com', password: 'Password11')
      expect(response.status).to eq (200)
      end


      it "fails if the user's email doesnt exist in the database" do
      response = post('/login', email: 'Made@email.com', password: 'Password11')
      expect(response.status).to eq (200)
      end

      it "fails if the user's password doesnt match the one stored in the database" do
      response = post('/login', email: 'David@email.com', password: 'Password221')
      expect(response.status).to eq (200)
      end
end


context "post /space/new" do
            it "creates a new space and adds it to the list of spaces" do
            response = post('/space/new', name: 'New Space', description: 'Good Space', price_per_night: 12, available_from: '2022-09-22', available_to: '2022-09-25', confirmed: 'f', requested: 'f')
            expect(response.status).to eq (302)
            end
      end


context "get /space/:id" do
            it "returns the correct space page" do
            response = get('/space/2', name: 'Buckingham Palace', description: 'Discover the magical world of the Palace, unique in England.', price_per_night: 40, available_from: '2022-09-12', available_to: '2022-09-15', confirmed: 'f', requested: 'f')
            expect(response.status).to eq (200)
            end
      end


context "get /request_form" do
            xit "returns a list of all requests recieved and made" do
            response = get('/request_form')
            expect(response.status).to eq (200)
            end
      end

context "post /confirm_email" do
            it "should send the user an email and redirect the owner to a confirmation page" do
            response = post('/confirm_email')
            expect(response.status).to eq (200)
            end
      end

context "post /deny_email" do
            it "should send the user an email and redirect the owner to a confirmation page" do
            response = post('/deny_email')
            expect(response.status).to eq (200)
            end
      end
end


