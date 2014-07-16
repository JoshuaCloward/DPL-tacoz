class SearchResultsController < ApplicationController

  def index
    @results = PgSearch.multisearch(params[:q]).collect(&:searchable)
    @location_results = Location.search(params[:q])
    @menu_item_results = MenuItem.search(params[:q])
  end
end
