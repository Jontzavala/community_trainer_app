require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, 'thebestsecreteverofalltime'
  end

  get "/" do
    if logged_in?
      redirect to '/workouts'
    else
      erb :index
    end
  end

  helpers do

    def logged_in?
      !!sessions[:user_id]
    end
    
    def current_user
      User.find_by_id(session[:user_id])
    end

    def redirect_to_if_logged_in
      redirect '/workouts' if logged_in?
    end

    def redirect_to_if_not_logged_in
      redirect '/login' unless logged_in?
    end
  
  end

end
