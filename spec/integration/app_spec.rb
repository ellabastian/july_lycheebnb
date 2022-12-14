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
            expect(response.body).to include '<h1 style="text-align: center;">  Welcome to Lychee MakersBnB</h1>'
      end 
end 

context 'GET /login' do
      it "should return the HTML page with sign-in" do
            response = get('/login')

            expect(response.status).to eq(200)
            expect(response.body).to include "<h2> Please, sign in below </h2>"
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
            expect(response.body).to include '<h2> Please, sign in below </h2>'
            end 

      it "creates a new user if information is valid" do
            response = post("/signup", name: 'George', email: 'George@gmail.com', password: 'George11')
            expect(response.status).to eq(302)

            response = get('/spaces')
            expect(response.body).to include '<h4> Filter by available dates: </h4>'
            end 
      end

context "GET /spaces" do
      it "returns a list of all spaces" do
            response = get("/spaces")
            expect(response.status).to eq (200)
            expect(response.body).to include ('<h2> Welcome to Lychee MakersBnB </h2>')
      end
end

context "GET /space/new" do
            it "returns a new space page" do
                  response = get("/space/new")
                  expect(response.status).to eq 200
                  expect(response.body).to include "<h3>Create A Space</h3>"
            end
      end

context "GET /confirmation" do
      it "returns the confirmations page" do
            response = get('/request_form/2')
            expect(response.status).to eq 200
            expect(response.body).to include "<h4 id='request_from_h3'>From: David@email.com</h4>"
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
      expect(response.body).to include '<h2>Login failed</h2>'
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
            response = get('/space/2', name: 'Somerset House', description: 'Discover the magical world of the Palace, unique in England.', price_per_night: 40, available_from: '2022-09-12', available_to: '2022-09-15', confirmed: 'f', requested: 'f')
            expect(response.status).to eq (200)
            expect(response.body).to include '<h3>Somerset House</h3><br>'
            end
      end


context "get /request_form" do
            it "returns a list of all requests recieved and made" do
            response = get('/request_form', selected_date: '2022-09-09', space_id: 2)
            expect(response.status).to eq (200)
            expect(response.body).to include '<h2 id ="colour">Requests I\'ve recieved</h2>'
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
            expect(response.body).to include '<h3 class="title" style="text-align: center;margin: 3rem 0;"> The user has now been notified that you denied their request to book this space</h3>'
            end
      end


context "get /filter" do
            it "should return all spaces that are available to be requested within that date range" do
            response = get('/filter', available_from:'2022-09-12', available_to: '2022-09-15')
            expect(response.status).to eq (200)
            expect(response.body).to include '<h3 class="card-title">Somerset House</h3>'
            end

            it "should redirect user to spaces if date inputs are empty" do
            response = get('/filter', available_from:'', available_to: '')
            expect(response.status).to eq (302)
            end
      end

context "get /about" do
            it "should return the about page" do
            response = get('/about')
            expect(response.status).to eq (200)
            expect(response.body).to include '<header class="w3-center"><p style="font-size: 38px; font-weight: 700;">LycheeBnB</p></header>'
            end
      end
end


