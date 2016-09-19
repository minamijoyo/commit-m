module CommitsHelper
  def highlight_message(commit)
    message = commit.try!(:highlight).try!(:message).try!(:join) || commit.message
    sanitize(message, tags: %w[mark])
  end
end
