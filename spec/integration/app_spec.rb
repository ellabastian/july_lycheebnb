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
            expect(response.body).to include "<h1> Please, sign in below </h1>"
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
            response = post('/signup', name: 'newuser', email: 'test1@email.com', password: 'password1')
            expect(response.status).to eq(200)
            expect(response.body).to include '<h1> Please, sign in below </h1>'
            end 

      it "creates a new user if information is valid" do
            response = post("/signup", name: 'Mike', email: 'Mike@gmail.com', password: 'Mike1234')
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

context "GET /confirmations" do
      it "returns the confirmations page" do
            response = get("/confirmations")
            expect(response.status).to eq 200
            expect(response.body).to include "<h3> Please confirm or deny your requests below </h3>"
            end
      end

context "POST /confirmations" do
      it "updates the confirmed column in the database to true when the user clicks confirm request button" do
            response = post("/confirmations", )
            expect(response.status).to eq 200
            end
      end

#       it "the confirmed column in the database remains false when the user clicks the deny request button" do
#             response = post("/confirmations")
#             expect(response.status).to eq 200
#             end
#       end

      

end
