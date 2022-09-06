require 'sinatra/base'
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
      user_repo = UserRepository.new
      email = params[:email]
      password = params[:password]

      # login fails if email doesnt exists in database
      user_email = user_repo.find_user_by_email(email)
      if user_email == nil
            erb :login_failed
      end

      # login fails if password doesnt match
      user_pass = user_repo.find_user_by_email(email)
      # binding.irb
      if user_pass.password != params[:password]
            erb :login_failed
      end

      erb :spaces
end


get '/spaces' do
      
end

end 

#redirect_to :signin, notice: "Oops something didn't work"
