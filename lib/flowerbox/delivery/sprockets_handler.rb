require 'sprockets'
require 'sprockets/engines'

module Flowerbox::Delivery
  class SprocketsHandler
    attr_reader :files, :options

    def initialize(options)
      @options = options

      @files = UniqueAssetList.new
    end

    def add(asset)
      paths_for(asset).each { |path| @files.add(path_for_compiled_asset(path)) }
    end

    def paths_for(asset)
      environment.find_asset(asset).to_a.collect(&:pathname)
    end

    def environment
      return @environment if @environment

      @environment = Sprockets::Environment.new
      @environment.unregister_postprocessor('application/javascript', Sprockets::SafetyColons)
      @environment.unregister_bundle_processor('text/css', Sprockets::CharsetNormalizer)
      @environment.register_engine('.js', Flowerbox::Delivery::Tilt::JSTemplate)
      @environment.register_engine('.css', Flowerbox::Delivery::Tilt::CSSTemplate)
      @environment.register_engine('.jst', Flowerbox::Delivery::Tilt::JSTTemplate)


      options[:asset_paths].each { |path| @environment.append_path(path) }
      @environment
    end

    def asset_for(*args)
      environment.find_asset(*args)
    end

    def path_for_compiled_asset(path)
      Pathname(asset_for(path, :bundle => false).to_s)
    end
  end
end
