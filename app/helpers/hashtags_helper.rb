module HashtagsHelper
  def render_with_hashtags(content)
    content_words = content.split(" ")
    content_with_links = content_words.map do |word|
      if word.include?("#")
        link_to word, hashtag_path(word.downcase.delete('#'))
      else
        word
      end
    end

    content_with_links.join(" ").html_safe
  end
end
