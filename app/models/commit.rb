class Commit < ActiveRecord::Base
  def self.search_message(keyword)
    if keyword.present?
      against_key = keyword.split.map { |key| key.insert(0,'+') }.join(' ')
      where("match(message) against (? in boolean mode)", "#{against_key}")
    else
      Commit.none
    end
  end
end
