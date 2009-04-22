class ItemsController < ApplicationController
  
  def index
    @items = Item.find(:all, :conditions => [], :order => 'modified_on DESC' )
  end

  def show
  end

end
