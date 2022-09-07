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
            end 
                  redirect '/spaces'
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

      get '/space/:id' do
            repo = SpaceRepository.new
            id = params[:id].to_i
            # binding.irb
            @space = repo.find(id)
            
            erb :space_id
      end

      #requests
      get '/request_form' do
            @repo = SpaceRepository.new
            # @space = repo.find(id)
            selected_date = params[:selection]
            # "2022-09-09"

            space_id = params[:space_id].to_i
            @space = repo.find(space_id)
            # @space.requested = 't'
            @repo.request_a_space(space_id)
            user_id = @space.user_id.to_i

            # binding.irb
            # req = repo.all_recieved_requests(user_id)
            # space.requested = 't'

            erb :requests
      end

      get '/confirmations' do
            erb :confirmations
      end

      post '/confirmations' do
            @space_repo = SpaceRepository.new
            requested = params[:requested]
            confirmed = params[:confirmed]

      end

end 