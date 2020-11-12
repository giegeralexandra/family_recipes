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
            flash[:login] = "Email & Password credentials are incorrect. Please try again."
            redirect "/login/error"
        end
    end

    get '/login/error' do 
        if Helpers.logged_in?(session)
            redirect "/recipes"
        elsif flash[:login]
            erb :'users/login_error'
        else 
            redirect "/login"
        end
    end

    post '/login/error' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect "/recipes"
        elsif flash[:login]
            redirect "/login/error"
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

    get '/users' do 
        if Helpers.logged_in?(session)
            @users = User.all 
            erb :'users/index'
        else 
            redirect '/login'
        end
    end

    get '/users/:slug' do 
        if Helpers.logged_in?(session)
            @user = User.find_by_slug(params[:slug])
            if @user 
                @recipes = @user.recipes
                erb :'users/show'
            else
                erb :'users/error'
            end
        else 
            redirect '/login'
        end
    end

end
