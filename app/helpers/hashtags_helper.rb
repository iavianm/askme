module HashtagsHelper
  def render_with_hashtags(content)
    content.gsub(Hashtag::TAG_REGEX) { |hashtag| link_to hashtag, hashtag_path(hashtag.downcase.delete('#')) }.html_safe
  end
end
