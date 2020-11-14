require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "pword01493"
  end

  helpers do 

    def current_user(session)
      User.find(session[:user_id])
    end

    def logged_in?(session)
      !!session[:user_id]
    end

  end

  get '/' do 
    erb :'users/homepage' 
  end 



end
