class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    question = Question.find(params[:question_id])
    current_user.favorite(question)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    question = Question.find(params[:question_id])
    current_user.unfavorite(question)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
