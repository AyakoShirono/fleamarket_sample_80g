class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  def show
    @items = @category.set_items
    @items = @items.where(buyer_id: nil).order("created_at DESC")
  end


  private
  def set_category
    @category = Category.find(params[:id])
  end
end
