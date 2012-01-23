require 'sprockets'

module Flowerbox::Delivery
  class SprocketsHandler
    attr_reader :files, :options

    def initialize(options)
      @options = options

      @files = []
    end

    def add(asset)
      @files += paths_for(asset)
    end

    def paths_for(asset)
      environment.find_asset(asset).to_a.collect(&:pathname)
    end

    def environment
      return @environment if @environment

      @environment = Sprockets::Environment.new
      options[:asset_paths].each { |path| @environment.append_path(path) }
      @environment
    end
  end
end
