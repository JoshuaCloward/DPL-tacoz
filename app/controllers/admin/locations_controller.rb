class Admin::LocationsController < AdminController
   before_action :find_location, only: [:update, :edit, :show, :destroy]

  def index
    @locations = Location.all
  end

  def show
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new
    if @location.save
      redirect_to admin_locations_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @location.update_attributes(location_params)
      redirect_to admin_locations_path
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
  end

  private

  def location_params
    params.require(:location).permit(:street_address, :street_address2, :city, :state, :zip,
    employees_attributes: [:name, :badge_id, :id, :_destroy])
  end

  def find_location
    @location = Location.find(params[:id])
  end

end
