class ItemsController < ApplicationController

  # require "payjp"
  before_action :set_item, only: [:show, :buy, :purchase]

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

  def buy
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to controller: "cards", action: 'new'
    elsif
      Payjp::Charge.create(amount: @item.price, customer: card.customer_id, currency: 'jpy')
      @item.update(buyer_id: current_user.id)
    else
      redirect_to root_path
    end
  end

  def purchase
    card = current_user.card
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
    Payjp::Charge.create(amount: @item.price, customer: card.customer_id, currency: 'jpy')
    if @item.update(buyer_id: current_user.id)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :detail, :condition, :category_id, :brand, :size_id, images_attributes: [:src], shipping_attributes: [:fee_burden, :method, :prefecture_from, :period_before_shipping]).merge(user_id: current_user.id)    
  end

end
