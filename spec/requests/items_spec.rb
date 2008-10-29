require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a item exists" do
  Item.all.destroy!
  request(resource(:items), :method => "POST", 
    :params => { :item => { :id => nil }})
end

describe "resource(:items)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:items))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of items" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a item exists" do
    before(:each) do
      @response = request(resource(:items))
    end
    
    it "has a list of items" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Item.all.destroy!
      @response = request(resource(:items), :method => "POST", 
        :params => { :item => { :id => nil }})
    end
    
    it "redirects to resource(:items)" do
      @response.should redirect_to(resource(Item.first), :message => {:notice => "item was successfully created"})
    end
    
  end
end

describe "resource(@item)" do 
  describe "a successful DELETE", :given => "a item exists" do
     before(:each) do
       @response = request(resource(Item.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:items))
     end

   end
end

describe "resource(:items, :new)" do
  before(:each) do
    @response = request(resource(:items, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@item, :edit)", :given => "a item exists" do
  before(:each) do
    @response = request(resource(Item.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@item)", :given => "a item exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Item.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @item = Item.first
      @response = request(resource(@item), :method => "PUT", 
        :params => { :article => {:id => @item.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@item))
    end
  end
  
end

