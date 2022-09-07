require_relative './request.rb'

class RequestRepository
  # Selecting all requests
  def all
    sql =  'SELECT * FROM requests;'
    result = DatabaseConnection.exec_params(sql,[])
    return request_object(result)
  end

  def all_requests_made_by_user(user_id)
    sql =  'SELECT * FROM requests WHERE user_id = $1;'
    result = DatabaseConnection.exec_params(sql,[user_id])
    return request_object(result)
  end

    private 

  def request_object(result)
    requests = []
    result.each do |record|
      request = Request.new
      request.id = record['id'].to_i
      request.requested_by_name = record['requested_by_name']
      request.space_name = record['space_name']
      request.date_requested = record['date_requested']
      request.user_id = record['user_id'].to_i

    requests << request
  end
  return requests
  end
end