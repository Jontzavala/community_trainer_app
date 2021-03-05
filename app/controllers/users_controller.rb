class UserController < ApplicationController
    get '/signup' do
        if logged_in?
            redirect '/workouts'
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        user = User.new(params)
        if user.save
            flash[:notice] = "You have succesfully signed up! Lets get in shape!"
            session[:user_id] = user.id
            redirect '/workouts'
        else
            flash.now[:error] = "Something went wrong, please try again"
            erb :'users/signup'
        end
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        @current_user = User.find_by(:username => params[:username], :email => params[:email])
        if @current_user && @current_user.authenticate(params[:password])
            session[:user_id] = @current_user.id
            flash[:notice] = "You're logged in! Lets start working out!"
            redirect '/workouts'
        else
            if @current_user
                flash.now[:error] = "Something went wrong, please try again"
                erb :'users/login'
            else
                flash.now[:error] = "Something went wrong, please try again"
                erb :'users/login'
            end
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/'
        else
            redirect '/'
        end
    end

end