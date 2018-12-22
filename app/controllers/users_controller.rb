class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params.each {|k,v| v.empty?}
      redirect "/signup"
    else
      @user = User.find_or_create_by(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do

    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :"/users/show"
  end



end
