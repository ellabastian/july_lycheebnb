require 'sinatra/base'
require "sinatra/reloader"
require_relative './lib/database_connection'
require_relative './lib/space_repository'
require_relative './lib/user_repository'
require_relative './lib/request_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
      configure :development do
            register Sinatra::Reloader
            also_reload 'lib/space_repository'
            also_reload 'lib/user_repository'
      end

      enable :sessions


      # Sign up pages
      get '/' do
            erb :sign_up, :layout => :layout
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
            erb :login, :layout => :layout
      end 

      post '/login' do
            @user_repo = UserRepository.new
            @space_repo = SpaceRepository.new

            email = params[:email]
            password = params[:password]

            # login fails if email doesnt exists in database
            @user = @user_repo.find_user_by_email(email)
            if @user == nil
                  return  erb :login_failed, :layout => :layout
            end

            # login fails if password doesnt match
            if @user.password != params[:password]
                  return erb :login_failed
            end
            
            erb :spaces, :layout => :layout
      end

      # list all spaces
      get '/spaces' do
            @space_repo = SpaceRepository.new

            return erb :spaces, :layout => :layout
      end


      # add a new space
      get '/space/new' do
            erb :space_new, :layout => :layout
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
            
            erb :space_id, :layout => :layout
      end

      #requests
      get '/request_form' do
            @repo = SpaceRepository.new
            @user_repo = UserRepository.new
            
            # "2022-09-09"
            @selected_date = params[:selection] # this is the selected date by the user

            # session[:booking] = []
            @space_class = Space.new

            if @space_class.array.include?(@selected_date)
                  return erb :date_exists, :layout => :layout
            end

            p @space_class.array.inspect
            # store these dates in the database 
            @space_class.array << @selected_date
            p @space_class.array.inspect

            # binding.irb
            # arr_of_bookings = @space_class.bookings

            space_id = params[:space_id].to_i # this is the space the user wants to book
            @repo.request_a_space(space_id)  # changing the requested status to true
      
            #binding.irb
            # req = repo.all_recieved_requests(user_id)
            # space.requested = 't'
            @space = @repo.find(space_id)
            user_id = @space.user_id.to_i
            @user = @user_repo.find(user_id)
            
            #find the users name
            # if @space.user_id == @user.id 
            # binding.irb
            @arr = @repo.all.filter {|space| space.user_id == @user.id && space.requested == 't'} 
            # returns all spaces that have been requested
            # end

            @requests = RequestRepository.new
            
            @req_made = @requests.all_requests_made_by_user(user_id)
            # binding.irb
            
            erb :requests, :layout => :layout
      end

      get '/request_form/:id' do
            @space_repo = SpaceRepository.new
            id = params[:id].to_i
            @space = @space_repo.find(id)

            # finding user
            @user_repo = UserRepository.new
            user_id = @space.user_id.to_i
            @user = @user_repo.find(user_id)

            erb :confirmation, :layout => :layout
      end
end 

