class ToppagesController < ApplicationController
  def index
    if logged_in?
    @pagy, @questions = pagy(current_user.questions.order(id: :desc))
    end
  end
end
