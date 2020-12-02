require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "pword01493"
    register Sinatra::Flash
  end

  get '/' do 
    if logged_in?(session)
      redirect "/recipes"
    else 
      erb :index 
    end 
  end

  helpers do 

    def current_user(session)
      User.find(session[:user_id])
    end

    def logged_in?(session)
      !!session[:user_id]
    end

    def redirect?
      if !logged_in?(session)
        redirect '/login'
      end
    end

  end 

end
