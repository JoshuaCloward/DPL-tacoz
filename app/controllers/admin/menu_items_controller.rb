class Admin::MenuItemsController < AdminController

  def index
    @menu_items = MenuItem.all.page(params[:page]).per(8)
  end

  def show
    @menu_item = MenuItem.find(params[:id])
  end

  def new
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      redirect_to admin_menu_items_path
    else
      render :new
    end
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def update
    @menu_item = MenuItem.find(params[:id])
    if @menu_item.update_attributes(menu_item_params)
      redirect_to admin_menu_items_path
    else
      render :edit
    end
  end

  def destroy
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy
    redirect_to admin_menu_items_path
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:name, :price, :description, :vegetarian, :picture,
    ingredients_attributes: [:name, :calories, :id, :_destroy])
  end

end
