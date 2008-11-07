class Items < Application
  # provides :xml, :yaml, :js
  before :ensure_authenticated, :exclude => [:index, :show]

  def index
    per_page_limit = 30
    @page = (params[:page] || 1).to_i
    item_offset = (@page-1)*per_page_limit 
    @items = Item.all(:order => [:created_at.desc], :limit => per_page_limit, :offset => item_offset)
    display @items
  end

  def show(id)
    @item = Item.get(id)
    raise NotFound unless @item
    display @item
  end

  def new
    only_provides :html
    @item = Item.new
    @item.user_id = session.user.id
    display @item
  end

  def edit(id)
    only_provides :html
    @item = Item.get(id)
    raise NotFound unless @item
    display @item
  end

  def create(item)
    @item = Item.new(item)
    if @item.save
      redirect resource(@item), :message => {:notice => "Item was successfully created"}
    else
      message[:error] = "Item failed to be created"
      render :new
    end
  end

  def update(id, item)
    @item = Item.get(id)
    raise NotFound unless @item
    if @item.update_attributes(item)
       redirect resource(@item)
    else
      display @item, :edit
    end
  end

  def destroy(id)
    @item = Item.get(id)
    raise NotFound unless @item
    if @item.destroy
      redirect resource(:items)
    else
      raise InternalServerError
    end
  end

end # Items
