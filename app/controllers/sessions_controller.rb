class SessionsController < ApplicationController

    get '/login' do 
        if Helpers.logged_in?(session)
            redirect "/recipes"
        else 
            erb :'users/login' 
        end
    end

end
