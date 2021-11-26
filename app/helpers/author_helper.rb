module AuthorHelper
  def author_name(author)
    if author.blank?
      'Аноним'
    else
      link_to "@#{author.username}", user_path(author)
    end
  end
end
