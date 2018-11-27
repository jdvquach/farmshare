class ItemsController < ApplicationController

  def app
    # raise 'hell'
  end

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

      if params[:file].present?
          response = Cloudinary::Uploader.upload params[:file]
          @item.item_image = response["public_id"]
          @item.save
      end
    #@item.save
    if @item.persisted?
      #raise('hell')
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

    if params[:search].present?

      #@items = Item.near(params[:search], 10,:units=>:km, :order => :distance)
      @items = Item.near(params[:search], 10, :units=>:km)
    else
      @items = Item.all.order('created_at DESC')
    end

  end

  def show
    @item = Item.find params[:id]
    @whereLat = (@item.latitude)
    @whereLng = (@item.longitude)

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
      if params[:file].present?
          response= Cloudinary::Uploader.upload params[:file]
          @item.item_image = response["public_id"]
          @item.save
      end
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
        params.require(:item).permit(:summary, :description, :item_image, :qty, :address, :category_id)
    end
end
