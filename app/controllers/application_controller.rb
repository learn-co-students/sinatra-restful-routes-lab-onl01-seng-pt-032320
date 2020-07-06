class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    redirect "/recipes"
  end

  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end

  post "/recipes" do
    @recipe = Recipe.new(params)
    if @recipe.save
      redirect "recipes/#{@recipe.id}"
    else 
      puts "Save Failure"
      redirect "index"
    end
  end

  get "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      erb :show
    else
      puts "Could Not find ID in Database."
      redirect "/recipes"
    end
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "recipes/#{@recipe.id}"
  end

  delete "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      Recipe.delete(@recipe.id)
      redirect "/recipes"
    else
      puts "RECIPE DID NOT DELETE!"
      redirect "/recipes"
    end
  end 
end
