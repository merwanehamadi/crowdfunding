# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    after(:build)  { |user| CreateUser.new.call(user: user) }
    password { 'password' }
    password_confirmation { 'password' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email  { "user_#{SecureRandom.hex(10)}@capsens.eu" }
    birthday  { "12/07/1998".to_date }
    country_of_residence { "FR" }
    nationality { "FR" }
  end
end
