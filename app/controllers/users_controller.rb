class UsersController < ApplicationController

    get '/login' do 
        if logged_in?(session)
            redirect "/recipes"
        else 
            erb :'/users/login' 
        end
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id 
            redirect "/recipes"
        else
            flash[:login_message] = "Username and email combination are invalid. Please try again or signup."
            redirect '/login'
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

    get '/signup' do 
        if logged_in?(session)
            redirect "/recipes"
        else 
            erb :'users/signup'
        end
    end

    post '/signup' do 
        if User.find_by(username: params[:username]) == nil 
            user = User.create(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], email: params[:email], password: params[:password])
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
