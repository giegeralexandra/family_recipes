class UsersController < ApplicationController

    

    get '/signup' do 
        if logged_in?(session)
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

    

    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect "/recipes"
        else
            redirect "/login"
        end
    end

    

    get '/users' do 
        if logged_in?(session)
            @users = User.all 
            erb :'users/index'
        else 
            redirect '/login'
        end
    end

    get '/users/:slug' do 
        if logged_in?(session)
            @user = User.find_by_slug(params[:slug])
            if @user 
                @recipes = @user.recipes
                erb :'users/show'
            else
                erb :'/users'
            end
        else 
            redirect '/login'
        end
    end

end
