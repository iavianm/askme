class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.with_questions.find_by!(text: params[:text])
    @questions = @hashtag.questions.includes(:user, :author, :hashtags, :hashtag_questions)
  end
end
