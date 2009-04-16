class Admin::FeedsController < ApplicationController
  
  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
  end

end
