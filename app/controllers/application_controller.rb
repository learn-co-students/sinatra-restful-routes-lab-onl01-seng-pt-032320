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
    if Recipe.all!=[]
      @recipes = Recipe.all
       erb :index
    else 
      redirect '/recipes/new'
    end
  end
  
  post '/recipes' do
    @recipe = Recipe.new
    @recipe.name = params[:name]
    @recipe.ingredients= params[:ingredients]
    @recipe.cook_time= params[:cook_time]
    if @recipe.save
        redirect "/recipes/#{@recipe.id}"
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
    if recipe.save
      redirect "/recipes/#{recipe.id}"
    else 
      @recipe = recipe
      erb :uerror
    end
  end
      
  delete '/recipes/:id' do 
    recipe = Recipe.find_by_id(params[:id])
    if recipe 
      recipe.delete
      redirect '/recipes'
    else
      @recipe = recipe
      erb :derror
    end
  end
  

end
