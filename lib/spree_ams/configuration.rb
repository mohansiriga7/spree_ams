require "singleton"

module Spree
  module Api
    module Ams
      class Configuration
        include Singleton

        cattr_accessor :cors_whitelist
        @@cors_whitelist = "https://pure-cove-84899.herokuapp.com/"

      end

      mattr_accessor :configuration
      @@configuration = Configuration

      def self.setup
        yield @@configuration
      end

    end
  end
end