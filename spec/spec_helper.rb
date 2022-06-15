require "bundler/setup"
require "ga4/tester"
require "selenium/webdriver"
require "capybara"
require "capybara/rspec"
require "yaml"

Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :headless_chrome
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions": { args: %w(headless disable-gpu) }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: capabilities)
end

def build_event(event_name, id, data_attributes, state)
  {
    "event" => "analytics",
    "event_name" => event_name,
    "gtm.uniqueEventId" => id,
    "link_url" => URI.parse(current_url).path,
    "ui" => {
      "index" => data_attributes["index"],
      "index-total" => data_attributes["index-total"],
      "section" => data_attributes["section"],
      "state" => state,
      "text" => data_attributes["text"],
      "type" => data_attributes["type"]
    }
  }
end

def fake(interactions)
  interactions["urls"].each do |url|
    puts "Generating data for: #{url}"
    visit url

    find_all(:xpath, "//#{interactions['tag']}[@class='#{interactions['class']}']").each do |link|
      event_count = page.evaluate_script("dataLayer").length
      link.click
      expect(page.evaluate_script("dataLayer").length).to eq(event_count + 1)
    end
  end
end
