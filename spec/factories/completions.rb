FactoryGirl.define do
  factory :completion do
    association :skill
    association :user

    trait(:verified) do
      created_at 2.weeks.ago
      verified_on 1.week.ago
    end
  end
end
