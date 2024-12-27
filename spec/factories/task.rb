FactoryBot.define do
  factory :task do
    title { "Default Title" }
    description { "Default Description" } 
    due_date { "2024-12-28" }
    association :category
  end
end