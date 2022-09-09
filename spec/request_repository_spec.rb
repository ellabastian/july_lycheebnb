require 'request_repository'
require 'request.rb'

def reset_requests_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe RequestRepository do
  before(:each) do 
    reset_requests_table
  end

  describe "#all" do
    it "finds all requests" do
      requests_repo = RequestRepository.new
      all_requests = requests_repo.all
      
      expect(all_requests.length).to eq(4)
      expect(all_requests[0].requested_by_name).to eq('Jake')
      expect(all_requests[0].space_name).to eq('Somerset House')
      expect(all_requests[0].date_requested).to eq('2022-09-09')
      expect(all_requests[0].user_id).to eq(1)
    end
 end

   describe "#all_requests_made_by_user" do
     it "returns all requests made by a user" do    
         repo = RequestRepository.new

         user = repo.all_requests_made_by_user(3)

         expect(user[0].requested_by_name).to eq("Mike")
         expect(user[0].space_name).to eq("Somerset House")
         expect(user[0].date_requested).to eq("2022-09-12")
     end
end
end