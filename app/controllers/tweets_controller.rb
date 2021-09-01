# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Current.user.tweets
  end

  def new
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.new
  end

  def create
    @tweet = Current.user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: "Tweet was schedule succesfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "Tweet was updated succesfully"
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "Tweet was unscheduled"
  end

  private
    def set_tweet
      @tweet = Current.user.tweets.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
    end
end
