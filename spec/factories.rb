FactoryGirl.define do
  factory :post do
    title 'Lorem Ipsum'
    body 'Something'
  end

  factory :user do
    email 'john@blog.com'
    password '123456'
  end
end
