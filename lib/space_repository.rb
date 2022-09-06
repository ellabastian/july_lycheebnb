require_relative './space.rb'

class SpaceRepository
  # Selecting all spaces
  def all
    sql =  'SELECT * FROM spaces WHERE confirmed = false;'
    result = DatabaseConnection.exec_params(sql,[])
    return space_object(result)
  end

  def create(space)
    sql = 'INSERT INTO spaces (name, description, price_per_night, available_from, available_to, requested, confirmed, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);'
    params = [space.name, space.description, space.price_per_night, space.available_from, space.available_to, space.requested, space.confirmed, space.user_id]
    DatabaseConnection.exec_params(sql,params)
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