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

end
