FactoryBot.define do
  factory :grid do
    dimension { 3 }
    rows { '111,100,101' }
  end

  factory :solution do
    number { 1 }
    grid factory: :grid
  end

  factory :step do
    add_attribute(:sequence) { 1 }
    row { 0 }
    index { 0 }
    solution factory: :solution
  end
end
