class RecipesController < ApplicationController

    get '/recipes' do 
        if Helpers.logged_in?(session)
            @user = Helpers.current_user(session)
            @breakfast = Recipe.all.select{|recipe| recipe.meal_type == "Breakfast"}
            @lunch = Recipe.all.select{|recipe| recipe.meal_type == "Lunch"}
            @snack = Recipe.all.select{|recipe| recipe.meal_type == "Snack"}
            @dinner = Recipe.all.select{|recipe| recipe.meal_type == "Dinner"}
            @dessert = Recipe.all.select{|recipe| recipe.meal_type == "Dessert"}
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

    get '/recipes/meal_type' do 
        if Helpers.logged_in?(session)
            @breakfast = Recipe.all.select{|recipe| recipe.meal_type == "Breakfast"}
            @lunch = Recipe.all.select{|recipe| recipe.meal_type == "Lunch"}
            @snack = Recipe.all.select{|recipe| recipe.meal_type == "Snack"}
            @dinner = Recipe.all.select{|recipe| recipe.meal_type == "Dinner"}
            @dessert = Recipe.all.select{|recipe| recipe.meal_type == "Dessert"}
            erb :'recipes/meals'
        else 
            redirect '/login'
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
                redirect "/recipes/#{params[:id]}/error"
            else 
                erb :"recipes/edit"
            end
        else 
            redirect '/login'
        end
    end

    patch '/recipes/:id' do 
        @recipe = Recipe.find(params[:id])
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
    end

    get '/recipes/:id/error' do 
        @recipe = Recipe.find(params[:id])
        if Helpers.logged_in?(session)
            erb :'recipes/edit_error'
        else 
            redirect '/login'
        end
    end

    delete '/recipes/:id' do 
        @recipe = Recipe.find(params[:id])
        if @recipe.user_id == session[:user_id]
            @recipe.destroy
            redirect "/recipes"
        else 
            redirect "/recipes/#{@recipe.id}/error"
        end        
    end

    
    #figure out how to require choice from radio button
    #put header and footer on each page in layout.erb
    #add logout, home, profile(slug), recipes, owners links to each page 
    #css, pictures do I want to add a img functionality? -- very last 
    
end
