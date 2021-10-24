class AnswersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @answer = current_user.answers.build(answer_params)
    @answer.question_id = params[:question_id]
    
    if @answer.save
      flash[:success] = '回答を投稿しました。'
      redirect_to ("/questions/#{params[:question_id]}")
    else
      @question = Question.find(params[:question_id])
      @pagy, @answers = pagy(@question.answers)
      flash.now[:danger] = '回答の投稿に失敗しました。'
      render ("/questions/show")
    end
  end

  
  private
  
  def answer_params
    params.require(:answer).permit(:content)
  end
end
