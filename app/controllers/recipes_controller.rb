class RecipesController < ApplicationController

    get '/recipes' do 
        if Helpers.logged_in?(session)
             @user = Helpers.current_user(session)
             @recipes = Recipe.all 
             erb :'recipes/index'
        else 
            redirect "/login"
        end
    end

    get '/recipes/new' do 
        if Helpers.logged_in?(session)
            erb :'/recipes/new'
        else 
            redirect '/login'
        end
    end

    post '/recipes' do 
    end

    get '/recipes/:id' do 
    end

    get '/recipes/:id/edit' do 
    end

    post 'recipes/:id' do 
    end

    delete '/recipes/:id' do 
    end

end
