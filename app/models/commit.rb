class Commit < ActiveRecord::Base
  include Commit::Searchable
  def self.search_message(keyword)
    if keyword.present?
      query = {
        "query": {
          "match": {
            "message": keyword
          }
        },
        "highlight": {
          "pre_tags": ['<mark>'],
          "post_tags": ['</mark>'],
          "fields": {
            "message": {}
          }
        }
      }
      Commit.__elasticsearch__.search(query)
    else
      Commit.none
    end
  end
end
