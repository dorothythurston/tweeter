class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
  end

  private
  def tweet_params
    params.require(:tweet).permit(:user_id).merge(user_id: current_user.id)
  end
end
