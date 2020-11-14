class SessionsController < ApplicationController

    get '/login' do 
        if Helpers.logged_in?(session)
            redirect "/recipes"
        else 
            erb :'sessions/login' 
        end
    end

    get '/logout' do 
        if Helpers.logged_in?(session)
            session.clear
            redirect "/login"
        else 
            redirect "/login"
        end
    end

end
