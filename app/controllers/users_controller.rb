class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').group_by{ |item| item.created_at.to_date }
  end
end
