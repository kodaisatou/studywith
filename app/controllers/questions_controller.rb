class QuestionsController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy]
  
  def new
    @question = Question.new
  end
  
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def create
    @question = current_user.questions.build(question_params)
    
    if @question.save
      flash[:success] = '質問を投稿しました。'
      redirect_to @question
    else
      @pagy, @questions = pagy(current_user.questions.order(id: :desc))
      flash.now[:danger] = '質問の投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @question.destroy
    flash[:success] = '質問を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def question_params
    params.require(:question).permit(:content)
  end
  
  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    unless @question
      redirect_to root_url
    end
  end
end
