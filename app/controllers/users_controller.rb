class UsersController < ApplicationController

    get '/' do 
        erb :'users/homepage' 
    end

    get '/signup' do 
        if Helpers.logged_in?(session)
            redirect "/recipes"
        else 
            erb :'users/signup'
        end

    end

    post '/signup' do 
        user = User.create(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], email: params[:email], password: params[:password])
        session[:user_id] = user.id 
        redirect "/recipes"
    end

    get '/login' do 
        if Helpers.logged_in?(session)
            redirect "/recipes"
        else 
            erb :'users/login' 
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
        if Helpers.logged_in?(session)
            session.clear
            redirect "/login"
        else 
            redirect "/login"
        end
    end

    get '/:slug' do 
        @user = User.find_by_slug(params[:slug])
        if @user 
            @recipes = @user.recipes
            erb :'users/show'
        else
            erb :'users/error'
        end

    end


end
