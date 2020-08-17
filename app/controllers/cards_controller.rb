class CardsController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user_id: current_user.id).first
    redirect_to card_path(card.id) if card.present?
  end

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(description: 'test', email: current_user.email, card: params['payjp-token'], metadata: {user_id: current_user.id})
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to card_path(@card.id)
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy
    card = current_user.card
    if card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to action: "new"
  end

  def show
    card = current_user.card
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
  end

end
