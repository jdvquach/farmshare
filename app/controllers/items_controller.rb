class ItemsController < ApplicationController

  # CREATE
  def new
        @item = Item.new   # create a blank object for the form_for helper to use
  end

  def create
    # Multi-step way to create a new Post record in the database
    # for when we have to add some data that is not in the submitted
    # form (i.e., the user ID from the currently logged-in user):
    # First make a .new object, set the extra field, then .save
    @item = Item.new( item_params )  # strong params
    @item.user = @current_user
    # raise "hell"
    # could also write: item.user_id = @current_user.id
    @item.save
    if @item.persisted?
      redirect_to items_path # redirect to index
    else
      # @post did not get saved to the DB
      flash[:errors] = @item.errors.full_messages # an array of error strings we can print
      # redirect_to new_item_path
      # Render a *different* action's template (new instead of create)
      # We do this so the form can be pre-populated with the values typed
      # in by the user when they submitted it the first time
      render :new
    end

  end

  # READ
  def index
    @items = Item.all.order('created_at DESC')
  end

  def show
    @item = Item.find params[:id]

  end

  # UPDATE
  def edit
    @item = Item.find params[:id]
  end

  def update
    @item = Item.find params[:id]  # key comes from /posts/:id
    # Check that the owner of this item is STILL the logged-in user
    # (i.e. the ID in the edit form action was not tampered with)
    unless @item.user == @current_user
      redirect_to(root_path) # this alone does not stop the action
    return  # stop the rest of the action from running! i.e. the update below
    end
    # check whether the update actually changed the DB or not
    # (.update returns true if it did change the DB, false if there was an error)
    if @item.update( item_params )
      # successfully updated the DB
      redirect_to item_path(@item) # redirect to show page
    else
      # error updating
      flash[:errors] = @item.errors.full_messages
      render :edit   # Render the edit template to show the form, even though this is the update action
    end
  end

  # DESTROY
  def destroy
    @item = Item.find params[:id]
    @item.destroy
    redirect_to( items_path )
  end

private

    #Security for the the CREATE and UPDATE
    def item_params
        params.require(:item).permit(:summary, :description, :item_image, :qty, :latitude, :longitude, :address, :category_id)
    end
end
