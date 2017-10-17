require 'selenium/webdriver'

module RainforestRubyRuntime
  module Drivers
    class Chrome
      def initialize(options)
        @options = options
      end

      def call
        ::Capybara.register_driver :chrome do |app|
          ::Capybara::Selenium::Driver.new(app, browser: :chrome)
        end
      end
    end
  end
end
