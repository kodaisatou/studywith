class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_questions = user.questions.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
end
