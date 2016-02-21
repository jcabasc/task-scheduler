Fabricator :user do
  email { Faker::Internet.email }
  password "Password!"
  password_confirmation "Password!"
end