FactoryGirl.define do
  factory :article do
    filename "01_filename.md"
    title Faker::Book.title
    slug { "#{title}".downcase.gsub(" ", "-") }
    markdown "hello world"
    content "<p>hello world</p>\n"
    author Faker::Name.name
  end
end
