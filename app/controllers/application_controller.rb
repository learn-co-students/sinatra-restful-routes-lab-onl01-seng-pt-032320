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
  
  get '/recipes/new' do 
    erb :new
  end
  
  post '/recipes/new' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    if @recipe 
        redirect '/recipes'
    else 
      erb :ierror
    end
  end
    
  get '/recipes/:id' do
      @recipe = Recipe.find_by_id(params[:id])
    
    
  erb :show
  end
  
  patch '/recipes/:id/edit' do 
  end
  
  
  delete '/recipes/:id' do 
  end
  

end
