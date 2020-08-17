class ItemsController < ApplicationController
  # before_action :set_parents, only: [:new, :create]

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def index
    @items = Item.includes(:images).order('created_at DESC')
    @parents = Category.all.order("id ASC").limit(13)
  end
  
  def show
  end

  def new
    @item = Item.new
    @item.user = current_user
    @item.images.new
    @item.build_shipping
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end
  
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
      if @item.save
        redirect_to root_path
      else
        redirect_to new_item_path
      end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :detail, :condition, :category_id, :category, :brand_id, :size_id, images_attributes: [:src], shipping_attributes: [:fee_burden, :method, :prefecture_from, :period_before_shipping, :id]).merge(user_id: current_user.id)    
  end

end
