class ItemsController < ApplicationController
  def index
    user = User.find_by(id: params[:user_id])
    if user
      items = user.items
      render json: items.as_json(include: :user)
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def show
    @item = User.find(params[:user_id]).items.find_by(id: params[:id])
    if @item
      render json: @item
    else
      render json: { error: "Item not found" }, status: :not_found
    end
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.build(item_params)

    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.permit(:name, :description)
  end
end