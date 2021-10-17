class QuestionsController < ApplicationController
    before_action :require_user_logged_in
  
  def new
    @question = Question.new
  end
  
  def show
    @question = Question.find(params[:id])
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
  end
  
  private
  
  def question_params
    params.require(:question).permit(:content)
  end
end
