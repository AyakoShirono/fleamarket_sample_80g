class ItemsController < ApplicationController
  #require "payjp"
  before_action :set_item, only: [:show, :buy, :purchase, :edit, :update, :destroy]
  before_action :not_edit, only: [:edit, :update]
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.includes(:images).order('created_at DESC')
    @parents = Category.all.order("id ASC").limit(13)
  end
  
  def show
    @size = Size.find_by(id: @item.size_id)
    @prefecture = Prefecture.find_by(id: @item.shipping.prefecture_from)
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
    @category_children = Category.find(params[:category_id]).children
  end
  def get_category_child
    @category_child = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
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
        redirect_to root_path, notice: "出品が完了しました"
      else
        redirect_to new_item_path, alert: "出品に失敗しました"
      end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(item_params), notice: "編集が完了しました"
    else
      redirect_to edit_item_path(item_params), alert: "編集に失敗しました"
    end
  end
  
  def destroy
    if current_user.id == @item.user_id && @item.destroy
      redirect_to root_path, notice: "削除しました"
    else
      redirect_to item_path(@item.id), notice: "削除できませんでした"
    end
  end

  def buy # 購入確認画面のアクション
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
    if card.blank?
      redirect_to controller: "cards", action: 'new' and return
    end
    if @item.buyer_id.present? || current_user.id == @item.user_id
      redirect_to root_path, notice: "不正なアクセスです"
    end
  end

  def purchase # 実際の購入のアクション
    card = current_user.card
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
    if @item.buyer_id.blank? && current_user.id != @item.user_id
      Payjp::Charge.create(amount: @item.price, customer: card.customer_id, currency: 'jpy')
      @item.update(buyer_id: current_user.id)
      redirect_to purchased_item_path
    else
      redirect_to root_path, notice: "購入できませんでした"
    end
  end

  def purchased
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :detail, :condition, :category_id, :category, :brand, :size_id, images_attributes: [:src, :_destroy, :id], shipping_attributes: [:fee_burden, :method, :prefecture_from, :period_before_shipping, :id]).merge(user_id: current_user.id)
  end

  def not_edit
    unless user_signed_in? && current_user.id == @item.user_id
      redirect_to action: :index
    end
  end
  
  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path, notice: "ログインしてください"
    end
  end
end
