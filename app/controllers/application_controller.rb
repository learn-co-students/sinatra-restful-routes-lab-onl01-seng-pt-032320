class ApplicationController < Sinatra::Base
  configure do
    set :method_override, 'true'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end
  
  get '/recipes' do 
    @recipes = Recipe.all
    if @recipes
       erb :index
    else 
      redirect '/recipes/new'
    end
  end
  
  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    if @recipe 
        redirect '/recipes'
    else 
      erb :ierror
    end
  end
    
  get '/recipes/:id' do
      @recipe = Recipe.find_by_id(params[:id])
      if @recipe
        erb :show
      else 
        erb :oerror
      end
  end
  
  get '/recipes/:id/edit' do 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe 
      erb :edit
    else 
      erb :oerror
    end
  end
  
  patch '/recipes/:id' do 
    nname = params[:name] 
    ningredients = params[:ingredients]
    ncooktime = params[:cook_time]
    recipe = Recipe.find_by_id(params[:id])
    recipe.name = nname
    recipe.ingredients = ningredients
    recipe.cook_time = ncooktime
    uprecipe = recipe.save
    if newrecipe
      redirect "/recipes/#{uprecipe.id}"
    else 
      erb :uerror
    end
  end
      
  delete '/recipes/:id' do 
    recipe = Recipe.find_by_id(params[:id])
    if recipe 
      recipe.delete
      redirect '/recipes'
    else
      erb :derror
    end
  end
  

end
