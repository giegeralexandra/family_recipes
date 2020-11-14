class SessionsController < ApplicationController

    get '/login' do 
        if logged_in?(session)
            redirect "/recipes"
        else 
            erb :'sessions/login' 
        end
    end

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect "/recipes"
        else
            redirect "/login"
        end
    end

    get '/logout' do 
        if logged_in?(session)
            session.clear
            redirect "/login"
        else 
            redirect "/login"
        end
    end

end
