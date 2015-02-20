FactoryGirl.define do
  factory :commit do
    sequence(:repo_full_name) { |n| "Repo#{n}" }
    sequence(:sha) { |n| "#{n}"}
    sequence(:message) { |n| "Message #{n}"}
  end
end
