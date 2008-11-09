class Votes < Application
  # provides :xml, :yaml, :js

  def index
    @votes = Vote.all
    display @votes
  end

  def show(id)
    @vote = Vote.get(id)
    raise NotFound unless @vote
    display @vote
  end

  def new
    only_provides :html
    @vote = Vote.new
    display @vote
  end

  def edit(id)
    only_provides :html
    @vote = Vote.get(id)
    raise NotFound unless @vote
    display @vote
  end

  def create(vote)
    puts vote.inspect
    @vote = Vote.new(vote)
    @vote.user = session.user
    if vote[:value] == 'up'
      @vote.value = 1
    elsif vote[:value] == 'down'
      @vote.value = -1
    else
      @vote.value = 0
    end
    if @vote.save
      redirect (request.referer || url(:items))
    else
      message[:error] = "Vote failed to be created"
      render :new
    end
  end

  def update(id, vote)
    @vote = Vote.get(id)
    raise NotFound unless @vote
    if @vote.update_attributes(vote)
       redirect resource(@vote)
    else
      display @vote, :edit
    end
  end

  def destroy(id)
    @vote = Vote.get(id)
    raise NotFound unless @vote
    if @vote.destroy
      redirect resource(:votes)
    else
      raise InternalServerError
    end
  end

end # Votes
