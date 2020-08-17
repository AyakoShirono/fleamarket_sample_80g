class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :buy, :purchase]

  def index
    @items = Item.all
  end

  def show
  end

  def buy
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to controller: "cards", action: 'new'
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

end
