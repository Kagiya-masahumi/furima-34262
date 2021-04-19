FactoryBot.define do
  factory :user do

    id                          {Faker::Number.number(digits:1)}
    nickname                    {"yamada"}
    email                       {Faker::Internet.free_email}
    password                    {'test1234TEST'}
    password_confirmation       {password}
    name                        {"太郎"}
    family_name                 {"山中"}
    name_kana                   {"タロウ"}
    family_name_kana            {"ヤマナカ"}
    birthday                    {"1990-01-01"}
  end
end