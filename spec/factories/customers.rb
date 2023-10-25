FactoryBot.define do
  factory :customer do
    rfc { "AAA010101000" }
  end

  factory :customer_2, class: 'Customer' do
    rfc { "BBB020202000" }
    id {2}
  end
end
