class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get "/" do
    redirect "/recipes"
  end

  get "/recipes" do
    @recipes=Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new_recipe
  end

  post "/recipes" do
    new_recipe = Recipe.new(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    if new_recipe.save
      redirect "/recipes/#{new_recipe.id}"
    else
      erb :error
    end
  end

  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end
  
  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end
  
  patch '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end
end
