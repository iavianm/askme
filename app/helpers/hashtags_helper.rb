module HashtagsHelper
  def render_with_hashtags(text)
    text.gsub(/#[[:word:]-]+/) { |word| word.delete('#').to_s }.html_safe
  end
end
