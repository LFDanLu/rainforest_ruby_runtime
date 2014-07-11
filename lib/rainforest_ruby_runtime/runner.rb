module RainforestRubyRuntime
  class Runner
    def self.run(code)
      extend RSpec::Matchers
      extend Capybara::DSL

      # Set up configuration
      Sauce.config do |c|
        c[:browsers] = [ ["Windows 7", "Firefox", "20"] ]
      end

      driver = ENV.fetch("CAPYBARA_DRIVER") { "selenium" }
      Capybara.default_driver = :"#{driver}"
      Capybara.default_wait_time = 20

      eval code
    end

    def self.extract_results(code)
      begin
        run(code)
      rescue RSpec::Expectations::ExpectationNotMetError => e
        return {
          exception: e.class.to_s,
          message: e.message,
          status: 'failed',
        }
      end

      {
        status: 'passed'
      }
    end
  end
end