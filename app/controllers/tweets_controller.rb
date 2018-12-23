class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.logged_in?(session)
      @tweets = Tweet.all
      @user = Helpers.current_user(session)
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'/tweets/new'
    else
      redirect :login
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      user = User.find_by(id: session[:user_id])
      tweet = Tweet.create(content: params[:content])
      user.tweets << tweet
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    binding.pry
    if Helpers.logged_in?(session) && params[:id] == session[:user_id]
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/edit_tweet'
    else
      binding.pry
      redirect to "/tweets"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.update(content: params[:content])
    redirect to '/tweets'
  end

  delete '/tweets/delete/:id' do
    tweet = Tweet.find_by(id: params[:id])
    tweet.destroy
    redirect to '/tweets'
  end


end
