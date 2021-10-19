class ToppagesController < ApplicationController
  def index
    if logged_in?
    @pagy, @questions = pagy(Question.all.order(id: :desc))
    end
  end
end
