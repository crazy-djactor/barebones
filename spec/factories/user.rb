def random_name
  ('a'..'z').to_a.shuffle.join
end

FactoryBot.define do
  factory :user, :class => 'User' do
    first_name { random_name }
    last_name { 'Test' }
    email { random_name + '@gmail.com'}
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end