class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.build(question_params)
    
    if @answer.save
      flash[:success] = '回答を投稿しました。'
      redirect_to @answer
    else
      @pagy, @answers = pagy(current_user.answers.order(id: :desc))
      flash.now[:danger] = '回答の投稿に失敗しました。'
      render :new
    end
  end

  def destroy
  end
end
