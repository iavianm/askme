class UsersController < ApplicationController
  def index; end

  def edit; end

  def new; end

  def show
    @user = User.new(
      name: 'Miha',
      username: 'iavianm',
      avatar_url: 'https://secure.gravatar.com/avatar/71269686e0f757ddb4f73614f43ae445?s=100'
    )
  end
end
