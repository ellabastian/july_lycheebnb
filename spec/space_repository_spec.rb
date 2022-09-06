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
      
      expect(all_spaces.length).to eq(3)
      expect(all_spaces[0].name).to eq('first')
      expect(all_spaces[0].description).to eq('Amazing space')
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

   new_space.name = 'fourth'
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
   expect(all_spaces[3].name).to eq('fourth')
   expect(all_spaces[3].description).to eq('good new_space')
   expect(all_spaces[3].price_per_night).to eq(35)
   expect(all_spaces[3].available_from).to eq('2022-09-24')
   expect(all_spaces[3].available_to).to eq('2022-09-30')
   expect(all_spaces[3].requested).to eq('f')
   expect(all_spaces[3].confirmed).to eq('f')
   expect(all_spaces[3].user_id).to eq(1)
  end
 end
end

