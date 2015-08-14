class Commit < ActiveRecord::Base
  include Commit::Searchable
  def self.search_message(keyword)
    if keyword.present?
      query = {
        "query": {
          "match": {
            "message": keyword
          }
        }
      }
      Commit.__elasticsearch__.search(query)
    else
      Commit.none
    end
  end
end
