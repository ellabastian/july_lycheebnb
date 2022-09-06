# Users & Spaces - Model and Repository Classes Design Recipe
```
  As a user, 
  So that I can use MakersBnb, 
  I would like to create an account

  As a user, 
  So that I can use MakersBnb, 
  I would like to view a list of spaces

  As a user, 
  So that I can use MakersBnb, 
  I would like to see specific information (name, description and price) about a space

  As a user, 
  So that I can see, create and book listings I would like to log in

  As a user, 
  So that I can use MakersBnb, 
  I would like to confirm bookings of my space

  As a user,
  So that I can maximise bookings for my space(s)
  I want to be able to a range of available booking dates for them
```
## 1. Design and create the Table
```sql

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  password text
);

----------------------------------------------------------------------------------------------------

CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price_per_night int,
  available_from date,
  available_to date,
  requested boolean,
  confirmed boolean,
  status boolean,
  user_id int,
  constraint fk_user foreign key(user_id) references users(id)
);

```
## 2. Create Test SQL seeds
```sql

TRUNCATE TABLE users, spaces RESTART IDENTITY;

INSERT INTO users (name, email, password) VALUES
('test1', 'test1@email.com', 'password111'),
('test2', 'test2@email.com', 'password222'),
('test3', 'test3@email.com', 'password333');

INSERT INTO spaces (name, description, price_per_night, available_from, available_to, requested, confirmed, user_id) VALUES
('first', 'Amazing space', 20, '2022-09-05', '2022-09-10', false, false, 1),
('second', 'Wonderful space', 40, '2022-09-12', '2022-09-15', false, false, 2),
('third', 'Relaxing space', 20, '2022-09-17', '2022-09-25', false, false ,3);

```
## 3. Implement the Model class
```ruby

# Model class
class User
  attr_accessor :id, :name, :email, :password
end

# Model class
class Space
  attr_accessor :id, :name, :description, :price_per_night, :available_from, :available_to, :requested, :confirmed, :user_id
end

```

## 4. Define the Repository Class interface
```ruby
# User Repository class
class UserRepository
  # Selecting all records
  def all
    # SELECT * FROM users;
  end

  # returns a single record 
  def find(id)
    # SELECT * FROM users WHERE id = $1;
  end

  # Adds new record to the users table
  def create(new_user)
    # INSERT INTO users (name, email, password) VALUES ($1, $2, $3);
  end
end

------------------------------------------------------------------------------------------------------------

# As a user, So that I can use MakersBnb, I would like to view a list of spaces

# Space Repository class
class SpaceRepository
  # Selecting all spaces
  def all
    # SELECT * FROM spaces WHERE status = false;
  end

  def create(new_space)
    # INSERT INTO spaces (name, description, price_per_night, available_from, available_to, requested, confirmed, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);
  end
end

```
## 5. Write Test Examples

```ruby
# EXAMPLES

# 1. Get all users
repo = UserRepository.new
users = repo.all

users.length # =>  3

users[0].id # =>  1
users[0].name # =>  'test1'
users[0].email # => 'test1@email.com'
users[0].password # =>  'password111'

users[1].id # =>  2
users[1].name # =>  'test2'
users[1].email # => 'test2@email.com'
users[1].password # =>  'password222'

users[2].id # =>  3
users[2].name # =>  'test3'
users[2].email # => 'test3@email.com'
users[2].password # =>  'password333'

# 2. Adds a new user 
repo = UserRepository.new

new_user = User.new
new_user.name # = 'David'
new_user.email # = 'David@david.com'
new_user.password #= David123
repo.create(new_user)

-----------------------------------------------------------------------------------------------

# 1. Adds a new space  
spaces_repo = SpaceRepository.new
new_space = Space.new
new_space.name # = 'room'
new_space.description # = 'just rent it quickly'
new_space.price_per_night #= 120
new_space.available_from #= 2022-09-06
new_space.available_to #= 2022-09-10
new_space.requestd #= false
new_space.confirmed #= false
new_space.user_id #= 1

spaces_repo.create(new_space)

# 2. Gets all spaces
spaces_repo = SpaceRepository.new
all_spaces = spaces_repo.all

all_spaces.length #= 4
all_spaces[0].name # =>  'first'
all_spaces[0].description # =>  'Amazing Space'

```
## 6. Reload the SQL seeds before each test run

```ruby
# EXAMPLE

def reset_users_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end
end

-----------------------------------------------------------------------------------------------

def reset_spaces_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe SpaceRepository do
  before(:each) do 
    reset_spaces_table
  end
end

```

## 7. Test-drive and implement the Repository class behaviour
```
Follow the test-driving process of red, green, refactor to implement the behaviour.

```