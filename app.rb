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
      erb :signup
end 

post '/signup' do 
      if params[:name] == nil || params[:email] == nil || params[:password] == nil
            status 400
            return ''
      end 

      name = params[:name]
      email = params[:email]
      password = params[:password]

      repo = UserRepository.new
      all_users = repo.all 

      all_users.each do |user| 
            if user.email.include? email   
                  # Want to flash a message before redirecting
                  # flash[:notice] = "Email already registered. Please log in" 
                  return erb(:login)
                  end 
            new_user = User.new
            new_user.name = name
            new_user.email = email 
            new_user.password = password

            repo.create(new_user)
            return erb(:spaces)
            end 
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
