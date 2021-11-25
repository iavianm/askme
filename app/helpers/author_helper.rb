module AuthorHelper
  def author_name(author)
    if author.blank?
      'Аноним'
    else
      author == current_user
      link_to "@#{author.username}", user_path(author)
    end
  end
end
