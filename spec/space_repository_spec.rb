require 'space_repository'
require 'space.rb'

def reset_spaces_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe SpaceRepository do
  before(:each) do 
    reset_spaces_table
  end

  describe "#all" do
    it "finds all spaces" do
      spaces_repo = SpaceRepository.new
      all_spaces = spaces_repo.all
      
      expect(all_spaces.length).to eq(5)
      expect(all_spaces[0].name).to eq('White House')
      expect(all_spaces[0].description).to eq('A small nest perched in the trees, out of sight at 4 meters from the ground.')
      expect(all_spaces[0].price_per_night).to eq(20)
      expect(all_spaces[0].available_from).to eq('2022-09-05')
      expect(all_spaces[0].available_to).to eq('2022-09-10')
      expect(all_spaces[0].requested).to eq('f')
      expect(all_spaces[0].confirmed).to eq('f')
      expect(all_spaces[0].user_id).to eq(1)
    end
 end

 describe '#create' do
  it 'creates a new space record' do
   repo = SpaceRepository.new
   new_space = Space.new

   new_space.name = 'Montreal'
   new_space.description = 'good new_space'
   new_space.price_per_night = 35
   new_space.available_from = '2022-09-24'
   new_space.available_to = '2022-09-30'
   new_space.requested = 'f'
   new_space.confirmed = 'f'
   new_space.user_id = 1
   repo.create(new_space)

   all_spaces = repo.all
   # binding.irb
   expect(all_spaces[3].name).to eq('Montreal')
   expect(all_spaces[3].description).to eq('A bridge house perched between a neighbourhood park and a bustling intersection.')
   expect(all_spaces[3].price_per_night).to eq(20)
   expect(all_spaces[3].available_from).to eq('2022-09-26')
   expect(all_spaces[3].available_to).to eq('2022-09-28')
   expect(all_spaces[3].requested).to eq('f')
   expect(all_spaces[3].confirmed).to eq('f')
   expect(all_spaces[3].user_id).to eq(4)
  end
 end

  describe "#all_recieved_requests" do
    it "returns all requests recieved" do    
        repo = SpaceRepository.new
        user = repo.all_recieved_requests(1)

        expect(user).to be
    end
end

  describe "#request_a_space" do
    it "updates a space request from false to true" do    
        repo = SpaceRepository.new
        user = repo.request_a_space(1)
        result = repo.find(1)

        expect(result.requested).to eq 't'
      end
  end

  describe "#filter_spaces" do
    it "returns all spaces that are within that date range" do    
        repo = SpaceRepository.new
        filter = repo.filter_spaces("2022-09-12", "2022-09-28")
        expect(filter).to be
    end
end
end

