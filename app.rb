require_relative './lib/database_connection'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/user_repository'
require_relative './lib/space_repository'

DatabaseConnection.connect

class MakersBnb < Sinatra::Base
 configure :development do
  register Sinatra::Reloader
 end



end
