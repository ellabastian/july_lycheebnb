require_relative './space.rb'

class SpaceRepository

 attr_accessor :bookings
  
  def initialize
    self.bookings = []
  end

  # Selecting all spaces
  def all
    sql =  'SELECT * FROM spaces WHERE confirmed = false;'
    result = DatabaseConnection.exec_params(sql,[])
    return space_object(result)
  end

  def all_recieved_requests(user_id)
    sql =  'SELECT * FROM spaces WHERE requested = true AND id = $1;'
    result = DatabaseConnection.exec_params(sql,[user_id])
    return space_object(result)
  end

  # space_id
  def request_a_space(id)
    sql = 'UPDATE spaces SET requested = true WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql,[id])
  end

  def find(id)
    sql =  'SELECT * FROM spaces WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql,[id])
    return space_object(result)[0]
  end

  def create(space)
    sql = 'INSERT INTO spaces (name, description, price_per_night, available_from, available_to, requested, confirmed, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);'
    params = [space.name, space.description, space.price_per_night, space.available_from, space.available_to, space.requested, space.confirmed, space.user_id]
    DatabaseConnection.exec_params(sql,params)
  end


  def confirm_space(id)
    sql = 'UPDATE spaces SET confirmed = true WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql,[id])
  end

    private 

  def space_object(result)
    spaces = []
    result.each do |record|
      space = Space.new
      space.id = record['id'].to_i
      space.name = record['name']
      space.description = record['description']
      space.price_per_night = record['price_per_night'].to_i
      space.available_from = record['available_from']
      space.available_to = record['available_to']
      space.requested = record['requested']
      space.confirmed = record['confirmed']
      space.user_id = record['user_id'].to_i
    
    spaces << space
  end
  return spaces
  end
end