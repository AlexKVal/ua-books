require "rails_helper"

RSpec.describe "Books" do
  specify "visiting" do
    book = create(:book, title: "Зубр шукає гніздо")

    oksana = create(:person, :with_alias, first_name: "Оксана", last_name: "Була", gender: "female")

    Work.create!(person_alias: oksana.main_alias, type: create(:text_author_type), book: book)
    Work.create!(person_alias: oksana.main_alias, type: create(:illustrator_type), book: book)

    visit "/#{book.id}"
    expect(page).to have_css :h1, text: /^Оксана Була «Зубр шукає гніздо»$/
    expect(page).to have_content "Авторка тексту Оксана Була"
    expect(page).to have_content "Ілюстраторка Оксана Була"

    expect(page.title).to eq "Оксана Була «Зубр шукає гніздо» на Українських книжках"
    expect(page).to have_css "link[rel='canonical'][href='http://www.example.com/#{CGI.escape "оксана-була-зубр-шукає-гніздо"}/#{book.id}']", visible: false
  end
end
