module HashtagsHelper
  def render_with_hashtags(content)
    content.gsub(/#[[:word:]-]+/) { |hashtag| link_to hashtag, hashtag_path(hashtag.downcase.delete('#')) }.html_safe
  end
end
