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
      redirect '/recipes'
    end
  end
  
  post '/recipes/:id' do 
    
  erb :show
  end
  
  patch '/recipes/:id/edit' do 
  end
  
  
  delete '/recipes/:id' do 
  end
  

end
