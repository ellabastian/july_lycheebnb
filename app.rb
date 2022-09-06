require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/space_repository'
require_relative 'lib/user_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
      configure :development do
        register Sinatra::Reloader
        also_reload 'lib/space_repository'
        also_reload 'lib/user_repository'
end

get '/' do
      return erb(:home)
end 

get '/signin' do
      return erb(:signin)
end 

post '/signup' do 
      return erb(:spaces)      
end 

end 

#redirect_to :signin, notice: "Oops something didn't work"