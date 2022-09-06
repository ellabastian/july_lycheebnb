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
      erb :sign_up
end 

post '/signup' do 
      return erb(:spaces)      

end 

get '/signin' do
      erb :login
end 

post '/login' do
      
end


get '/spaces' do
      
end

end 

#redirect_to :signin, notice: "Oops something didn't work"
