class UsersController < ApplicationController
  before_action :load_user, except: %i[index create new]
  # Проверяем имеет ли юзер доступ к экшену, делаем это для всех действий, кроме
  # :index, :new, :create, :show — к этим действиям есть доступ у всех, даже у
  # тех, у кого вообще нет аккаунта на нашем сайте.
  before_action :authorize_user, except: %i[index new create show]

  def index
    @users = User.all
  end

  def edit; end

  def new
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Пользователь успешно зарегистрирован'
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
    @questions_amount = @questions.length
    @answers_amount = @questions.where.not(answer: nil).length
    @unanswered_amount = @questions_amount - @answers_amount
  end

  def destroy
    User.destroy(session[:user_id])

    redirect_to root_path, notice: 'Пользователь удален :('
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :color)
  end
end
