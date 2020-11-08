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
        #figure out how to require radio button choice 
        if params[:meal_type] == nil 
            redirect "/recipes/new"
        elsif Helpers.logged_in?(session)
            recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], directions: params[:directions], meal_type: params[:meal_type], user_id: session[:user_id])
            redirect "/recipes/#{recipe.id}"
        else 
            redirect "/login"
        end
    end

    get '/recipes/:id' do 
        @recipe = Recipe.all.find(params[:id])
        if Helpers.logged_in?(session)
            erb :'recipes/show'
        else 
            redirect '/login'
        end
    end

    get '/recipes/:id/edit' do 
        if Helpers.logged_in?(session)
            @recipe = Recipe.find(params[:id])
            if @recipe.user_id != session[:user_id]
                redirect "/recipes/#{params[:id]}"
            else 
                erb :"recipes/edit"
            end
        else 
            redirect '/login'
        end
    end

    patch '/recipes/:id' do 
        @recipe = Recipe.find(params[:id])
        #if (Helpers.logged_in?(session)) && (@recipe.user_id == session[:user_id])  
        if params[:name] != ""
            @recipe.update(name: params[:name])
        end
        if params[:ingredients] != ""
            @recipe.update(ingredients: params[:ingredients])
        end
        if params[:directions] != ""
            @recipe.update(directions: params[:directions])
        end
        if params[:meal_type] != ""
            @recipe.update(meal_type: params[:meal_type])
        end
        redirect "/recipes/#{@recipe.id}"
        #elsif (Helpers.logged_in?(session)) && (@recipe.user_id != session[:user_id])
            #redirect "/recipes/#{@recipe.id}"
        #else 
            #redirect "/login"
    end

    delete '/recipes/:id' do 
        @recipe = Recipe.find(params[:id])
        if @recipe.user_id == session[:user_id]
            @recipe.destroy
            redirect "/recipes"
        else 
            redirect "recipes/#{@recipes.id}"
        end        
    end

    #view recipes by owner or slug
    #view all owners with links
    #view recipes by meal type 
    #link recipes 
    #add logout links to each page 
    #add home, profile(slug) links to each page 
    #fix error page 
    #add functionality that gives custom errors - you cannot edit tweet, etc. 
    #format
    #css, pictures do I want to add a img functionality? -- very last 
    #put header and footer on each page in layout.erb
end
