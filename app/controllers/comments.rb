class Comments < Application
  # provides :xml, :yaml, :js

  def index
    @comments = Comment.all
    display @comments
  end

  def show(id)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    display @comment
  end

  def new(item_id)
    only_provides :html
    @comment = Comment.new
    @comment.user = session.user
    @comment.item_id = item_id
    display @comment
  end

  def edit(id)
    only_provides :html
    @comment = Comment.get(id)
    raise NotFound unless @comment
    display @comment
  end

  def create(comment)
    @comment = Comment.new(comment)
    if @comment.save
      redirect url(:item, @comment.item), :message => {:notice => "Comment was successfully created"}
    else
      message[:error] = "Comment failed to be created"
      render :new
    end
  end

  def update(id, comment)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    if @comment.update_attributes(comment)
       redirect resource(@comment)
    else
      display @comment, :edit
    end
  end

  def destroy(id)
    @comment = Comment.get(id)
    raise NotFound unless @comment
    if @comment.destroy
      redirect resource(:comments)
    else
      raise InternalServerError
    end
  end

end # Comments
