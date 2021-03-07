class WorkoutsController < ApplicationController

    get '/workouts' do
        redirect_to_if_not_logged_in
        @user = current_user
        @workouts = Workout.all
        erb :'/workouts/index'
    end

    get '/workouts/new' do
        redirect_to_if_not_logged_in
        erb :'/workouts/new'
    end

    post '/workouts' do
        @workout = current_user.workouts.create(params)
        if @workout.save
            redirect '/workouts'
        else
            redirect '/workouts/new'
        end
    end

    get '/workouts/:id' do
        @user = current_user
        @workout = Workout.find_by_id(params[:id])
        if logged_in? && @workout.user_id == current_user.id
            if @workout
                erb :'/workouts/show'
            end
        else
            flash[:fail] = "You don't have any workouts listed"
            redirect '/workouts'
        end
    end

    get '/workouts/:id/edit' do
        redirect_to_if_not_logged_in
         @workout = Workout.find_by_id(params[:id])
         if logged_in? && @workout.user_id == current_user.id
            erb :'/workouts/edit'
         else
            flash[:error] = "You can't edit another users workouts"
            redirect '/workouts'
         end
    end

    patch '/workouts/:id/edit' do
        redirect_to_if_not_logged_in
        @workout = Workout.find_by_id(params[:id])
        if logged_in? && @workout.user_id == current_user.id
            @workout.title = params[:title]
            @workout.description = params[:description]
            @workout.duration = params[:duration]
            @workout.save
            redirect "/workouts/#{@workout.id}"
        else
            redirect '/workouts'
        end
    end

    delete '/workouts/:id/delete' do
        @workout = Workout.find_by_id(params[:id])
        if logged_in? && @workout.user_id == current_user.id
            @workout.destroy
        end
        redirect '/workouts'
    end

end