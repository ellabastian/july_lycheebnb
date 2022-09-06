require 'sinatra/base'
require "sinatra/reloader"
require_relative './lib/database_connection'
require_relative './lib/space_repository'
require_relative './lib/user_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
      configure :development do
            register Sinatra::Reloader
            also_reload 'lib/space_repository'
            also_reload 'lib/user_repository'
      end

      # Sign up pages
      get '/' do
            erb :sign_up
      end 

      post '/signup' do 
            return erb(:spaces)      
      end 

      # login pages
      get '/login' do
            erb :login
      end 

      post '/login' do
            @user_repo = UserRepository.new
            @space_repo = SpaceRepository.new

            email = params[:email]
            password = params[:password]

            # login fails if email doesnt exists in database
            @user = @user_repo.find_user_by_email(email)
            if @user == nil
                  return  erb :login_failed
            end

            # login fails if password doesnt match
            if @user.password != params[:password]
                  return erb :login_failed
            end
            
            erb :spaces
      end

      # list all spaces
      get '/spaces' do
            @space_repo = SpaceRepository.new

            return erb :spaces
      end

      # add a new space
      get '/space/new' do
            erb :space_new
      end

      post '/space/new' do
            @space_repo = SpaceRepository.new
            name = params[:name]
            description = params[:description]
            price_per_night = params[:price_per_night]
            available_from = params[:available_from]
            available_to = params[:available_to]

            if name != nil && description != nil && price_per_night != nil && available_from != nil && available_to != nil
            space = Space.new
            space.name = name
            space.description = description
            space.price_per_night = price_per_night
            space.available_from = available_from
            space.available_to = available_to
            space.confirmed = 'f'
            space.requested = 'f'
            # binding.irb
            @space_repo.create(space)
            end

            redirect '/spaces'
      end
end 