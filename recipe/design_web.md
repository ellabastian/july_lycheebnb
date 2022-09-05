# Post - Model and Repository Classes Design Recipe

<!-- As a user, So that I can use MakersBnb, I would like to create an account -->

<!-- As a user, So that I can use MakersBnb, I would like to view a list of spaces -->

As a user, So that I can use MakersBnb, I would like to see specific information (name, description and price) about a space

As a user, So that I can see, create and book listings I would like to log in

As a user, So that I can use MakersBnb, I would like to confirm bookings of my space

As a user So that I can maximise bookings for my space(s) I want to be able to a range of available booking dates for them

[Account Route, Account Page]

## 1. Design and create the Table
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  password text,
);
```

```sql
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
<!-- ## 2. Create Test SQL seeds
```sql
TRUNCATE TABLE users, posts RESTART IDENTITY;

INSERT INTO users (name, username, email, password) VALUES ('Moe', 'moeez', 'moeez@gmail.com', 'strong123');
INSERT INTO users (name, username, email, password) VALUES ('Joe', 'joeez', 'joeez@gmail.com', 'weak123');
INSERT INTO users (name, username, email, password) VALUES ('Foe', 'foeez', 'foeez@gmail.com', 'wicked123'); -->
<!-- 

INSERT INTO posts (message, timestamp, user_id) VALUES ('first message', '2022-03-01 12:00:00', 1);
INSERT INTO posts (message, timestamp, user_id) VALUES ('second message', '2022-12-04 12:00:00', 2);
INSERT INTO posts (message, timestamp, user_id) VALUES ('third message', '2022-10-06 12:00:00', 3); 
```-->
## 3. Implement the Model class
```ruby
# Model class
class User
  attr_accessor :id, :name, :email, :password
end

# Model class
class Space
  attr_accessor :id, :name, :description, :price_per_night, :available_from, :available_to, :status, :user_id
end
```

## 4. Define the Repository Class interface

```ruby
# Repository class
class UserRepository
#   # Selecting all records
#   def all
#     # SELECT id, message, timestamp, user_id FROM posts;
#   end

#   # returns a single record 
#   def find(id)
#     # SELECT id, message, timestamp, user_id FROM posts WHERE id = $1;
#   end

#   # returns a single record by user_id
#   def find_by_user_id(user_id)
#     # SELECT id, message, timestamp, user_id FROM posts WHERE user_id = $1;
#   end

  # Adds new record to the posts table
  def create(new_post)
    # INSERT INTO posts (name, email, password) VALUES ($1, $2, $3);
  end

#   # Updates the message
#   def update_message(id, message)
#     # UPDATE posts SET message = $2 WHERE id = $1;
#   end

#   # Removes a record
#   def delete(id)
#     # DELETE FROM posts WHERE id = $1;
#   end
end
As a user, So that I can use MakersBnb, I would like to view a list of spaces
class SpaceRepository
  # Selecting all records
  def all
    SELECT * FROM spaces WHERE status = false;
  end

  def create(new_post)
    INSERT INTO spaces (name, description, price_per_night, available_from, available_to, status, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7);
  end
end
```
## 5. Write Test Examples

```ruby
# EXAMPLES

# 1. Get all posts
repo = UserRepository.new
spaces_repo = SpaceRepository.new

spaces = repo.all

# posts.length # =>  4

# posts[0].id # =>  1
# posts[0].message # =>  'First'
# posts[0].timestamp # => '2022-07-15 12:00:00'
# posts[0].user_id # =>  1

# posts[1].id # =>  2
# posts[1].message # =>  'Second'
# posts[1].timestamp # => '2022-07-15 12:00:00'
# posts[1].user_id # =>  2

# posts[2].id # =>  3
# posts[2].message # =>  'Third'
# posts[2].timestamp # => '2022-07-16 12:00:00'
# posts[2].user_id # =>  3

# # 2. Get a single post by id
# repo = PostRepository.new

# post = repo.find(1)

# post.id # =>  1
# post.message # =>  'First'
# post.timestamp # => '2022-07-15 12:00:00'
# post.user_id # =>  1

# 3. Adds new record 
repo = UserRepository.new

new_user = User.new
new_user.name # = 'David'
new_user.email # = 'David@david.com'
new_user.password #= David123
repo.create(new_user)

spaces_repo = SpaceRepository.new
spaces = repo.all

new_space = Space.new
new_space.name # = 'David'
new_space.description # = 'David@david.com'
new_space.price_per_night #= David123
new_space.available_from #= David123
new_space.available_to #= David123
new_space.status #= David123available_fromw_space)
new_space.user_id #= David123available_fromw_space)

spaces_repo.create(new_space)
all_spaces = spaces_repo.all
all_spaces.length #= 1

# posts = repo.all

# posts.length # =>  5
# posts.last.message # =>  'rain'
# posts.last.user_id # =>  3

# # 4. updates a message
# repo = PostRepository.new
# repo.update(2, 'message', 'cloud')

# posts = repo.all
# posts[1].id # =>  2
# posts[1].message # =>  'cloud'
# posts[1].timestamp # =>  '2022-07-15 12:00:00'
# posts[1].user_id # =>  2


# # 5. 'deletes a post' 
# repo = PostRepository.new

# repo.delete(1)
# posts = repo.all

# posts.length # =>  3
# posts.first.id # =>  2

```
## 6. Reload the SQL seeds before each test run

```ruby
# EXAMPLE

def reset_users_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_testing' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end
end

def reset_spaces_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_testing' })
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