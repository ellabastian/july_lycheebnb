require 'user_repository'
require 'user.rb'

describe UserRepository do
def reset_users_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_users_table
  end

describe "#all" do
  it "finds all users" do
    repo = UserRepository.new
    users = repo.all

    # binding.irb
    expect(users.length).to eq(4)
    
    expect(users[0].id).to eq (1)
    expect(users[0].name).to eq ('Jake')
    expect(users[0].email).to eq ('Jake@email.com')
    expect(users[0].password).to eq ('Password11')

    expect(users[1].id).to eq(2)
    expect(users[1].name).to eq('David')
    expect(users[1].email).to eq('David@email.com')
    expect(users[1].password).to eq('Password11')

    expect(users[2].id).to eq(3)
    expect(users[2].name).to eq('Mike')
    expect(users[2].email).to eq('Mike@email.com')
    expect(users[2].password).to eq('Password11')
  end
 end
 
  describe "#create" do
    it "creates a new user" do    
        repo = UserRepository.new

        new_user = User.new
        new_user.name = 'Kermit'
        new_user.email = 'muppets@muppet.com'
        new_user.password = 'Password11'
        repo.create(new_user)
        
        all_users = repo.all

        expect(all_users[3].name).to eq('Joe')
    end
  end

  describe "#find_user_by_email" do
  it "returns a single user from their given email" do    
      repo = UserRepository.new

      user = repo.find_user_by_email('David@email.com')

      expect(user.email).to eq('David@email.com')
      expect(user.name).to eq('David')
      expect(user.password).to eq('Password11')
  end
end

end
