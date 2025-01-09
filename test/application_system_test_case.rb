require "test_helper"
require 'capybara/rails'
require 'selenium/webdriver'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  Selenium::WebDriver::Chrome::Service.driver_path = '/usr/bin/chromedriver'
  
  Capybara.register_driver :selenium do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.binary = '/usr/bin/google-chrome' # Correct path to the Chrome binary
    # options.add_argument('--headless') # Optional: Run in headless mode
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
    options.add_argument('--remote-debugging-port=9222')
    options.add_argument('--user-data-dir=/tmp/chrome_user_data') 
    options.add_argument('--profile-directory=Default')

    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options, desired_capabilities: { "goog:loggingPrefs" => { "performance" => "ALL" } }) do |browser| 
      t = 3
      def browser.go_forward 
        sleep(t) # Adjust the sleep duration as needed 
        super 
      end 
      
      def browser.go_back 
        sleep(t) # Adjust the sleep duration as needed 
        super 
      end 
      
      def browser.refresh 
        sleep(t) # Adjust the sleep duration as needed 
        super 
      end

      def browser.visit 
        sleep(t) # Adjust the sleep duration as needed 
        super 
      end

    end 
  end 
  
  Capybara.default_driver = :slow_selenium_chrome 
  Capybara.javascript_driver = :slow_selenium_chrome

  # Set default max wait time
  Capybara.default_max_wait_time = 5 # Adjust as needed

  # Add a method to slow down tests
  def slow_down
    sleep 3 # Adjust the sleep duration as needed
  end

  # helpers
  def log_in_as(user)
    visit new_session_path
    fill_in "email_address", with: user.email_address
    fill_in "password", with: 'password' # Use the password you set in your fixtures
    # Ensure the button is present and clickable
    assert_selector "#sign_in_button"
    find("#sign_in_button").click
    slow_down
  end
end