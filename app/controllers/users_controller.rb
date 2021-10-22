class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :favorite_questions]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 20)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @questions = pagy(@user.questions.order(id: :desc))
    @question = Question.find(params[:id])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy, @users = pagy(@user.followings)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @pagy, @users = pagy(@user.followers)
    counts(@user)
  end
  
  def favorite_questions
    @user = User.find(params[:id])
    @pagy, @questions = pagy(@user.favorite_questions)
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
