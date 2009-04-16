class Admin::FeedsController < ApplicationController

  # GET /admin/feeds
  def index
    @feeds = Feed.active
    respond_to do |format|
      format.html
    end
  end

  # GET /admin/feeds/new
  def new
    @feed = Feed.new
    respond_to do |format|
      format.html
    end
  end

  # POST /admin/feeds
  def create
    @feed = Feed.new(params[:feed])
    respond_to do |format|
      if @feed.save
        format.html { redirect_to admin_feeds_path }
      else
        format.html { render new_admin_feed_path }
      end
    end
  end

  # DELETE /admin/feeds/1
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to admin_feeds_path
  end

end
