require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  
  setup do
    @quote = Quote.ordered.first # Reference to the first fixture quote
  end

  test "showing a quote" do
    visit quotes_path
    click_link @quote.name
    slow_down
    assert_selector "h1", text: @quote.name
    slow_down
  end

  test "Creating a new quote" do

    visit quotes_path
    assert_selector "h1", text: "Quotes"

  
    click_on "New quote"
    fill_in "Name", with: "Capybara quote"

    assert_selector "h1", text: "Quotes"
    click_on "Create quote"
  
    assert_selector "h1", text: "Quotes"
    assert_text "Capybara quote"
  
  end

  test "Updating a quote" do 
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    click_on "Edit", match: :first
    fill_in "Name", with: "Updated quote"

    assert_selector "h1", text: "Quotes"
    click_on "Update quote"

    assert_selector "h1", text: "Quotes"
    assert_text "Updated quote"
  end

  test "Deleting a quote" do
    visit quotes_path
    assert_text @quote.name

    click_on "Delete", match: :first
    assert_no_text @quote.name
  end
  # test "visiting the index" do
  #   visit quotes_url
  #
  #   assert_selector "h1", text: "Quotes"
  # end
end
