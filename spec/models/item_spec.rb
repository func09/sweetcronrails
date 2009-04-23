require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Item do

  def create_item params = {}
    item = Factory.build(:item, params)
  end
  
  before(:each) do
    @item = create_item
  end

  it "アイテムは正常に生成できること" do
    @item.save.should be_true
  end

end
