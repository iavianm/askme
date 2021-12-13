class HashtagsController < ApplicationController
  
  def show
    @hashtag = Hashtag.find_by(text: params[:id])
    @questions = @hashtag.questions
  end
end
