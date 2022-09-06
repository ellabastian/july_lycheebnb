require_relative './user.rb'
class UserRepository
  # Selecting all records
  def all
    sql = 'SELECT * FROM users;'
    result = DatabaseConnection.exec_params(sql,[])
    return users_object(result)
  end

  # # returns a single record 
  # def find(id)
  #   # SELECT * FROM users WHERE id = $1;
  # end

  # Adds new record to the users table
  def create(user)
    sql = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3);'
    params = [user.name, user.email, user.password]
    DatabaseConnection.exec_params(sql,params)
  end


  private 

  def users_object(result)
   users = []
   result.each do |record|
    user = User.new
    user.id = record['id'].to_i
    user.name = record['name']
    user.email = record['email']
    user.password = record['password']

    users << user
  end
  return users
 end
end
