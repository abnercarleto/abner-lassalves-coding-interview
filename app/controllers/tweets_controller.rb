class TweetsController < ApplicationController
  def index
    render json: Tweet
                 .most_recently
                 .by_user(User.by_username(search_params[:user_username]))
                 .limit(page_size)
                 .offset(page)
  end

  private

  def search_params
    params.permit(:user_username)
  end

  def pagination_params
    params.permit(:page, :page_size)
  end

  def page_size
    pagination_params.fetch(:page_size, 10).to_i
  end

  def page
    pagination_params.fetch(:page, 0).to_i * page_size
  end
end
