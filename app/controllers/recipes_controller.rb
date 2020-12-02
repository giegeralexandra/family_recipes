class RecipesController < ApplicationController

    get '/recipes' do 
        if logged_in?(session)
            @user = current_user(session)
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
        if logged_in?(session)
            erb :'/recipes/new'
        else 
            redirect '/login'
        end
    end

    post '/recipes' do 
        if logged_in?(session)
            if !params[:recipe][:meal_type]
                flash[:new_message] = "You must fill in Name, Ingredients, Directions and select Meal Type. Please try again."
                redirect "/recipes/new"
            else
                current_user.recipes.create(params[:recipe])
                redirect "/recipes/#{recipe.id}"
            end
        else 
            redirect "/login"
        end
    end

    get '/recipes/:id' do 
        redirect?
        @recipe = Recipe.find(params[:id])
        erb :'recipes/show'
    end

    get '/recipes/:id/edit' do 
        if logged_in?(session)
            @recipe = Recipe.find(params[:id])
            if @recipe.user_id == session[:user_id]
                erb :'/recipes/edit'
            else
                flash[:edit_message] = "You cannot edit a recipe that you do not own."
                redirect "/recipes/#{params[:id]}"
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
        if params[:meal_type] != nil
            @recipe.update(meal_type: params[:meal_type])
        end
        redirect "/recipes/#{@recipe.id}"
    end

    delete '/recipes/:id' do 
        @recipe = Recipe.find(params[:id])
        if @recipe.user_id == session[:user_id]
            @recipe.destroy
            redirect "/recipes"
        else 
            flash[:edit_message] = "You cannot delete a recipe that you did not create."
            redirect "/recipes/#{@recipe.id}"
        end        
    end
    
end
