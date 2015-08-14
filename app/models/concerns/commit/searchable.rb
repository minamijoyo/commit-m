require 'active_support/concern'
module Commit::Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    index_name "commitm"

    settings index: {
      number_of_shards: 1,
      number_of_replicas: 0
    } do
      mapping _source: { enabled: true } do
        indexes :id, type: 'integer', index: 'not_analyzed'
        indexes :repo_full_name, type: 'string'
        indexes :sha, type: 'string', index: 'not_analyzed'
        indexes :message, type: 'string'
      end
    end
  end

  module ClassMethods
    def create_index!(options={})
      client = __elasticsearch__.client
      client.indices.delete index: "commitm" rescue nil if options[:force]
      client.indices.create index: "commitm",
        body: {
          settings: settings.to_hash,
          mappings: mappings.to_hash
        }
    end
  end
end
