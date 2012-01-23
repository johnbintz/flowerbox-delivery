require 'erb'

module Flowerbox::Delivery
  class TemplateRenderer
    class FileTypeError < StandardError ; end

    attr_reader :options

    def initialize(options)
      @options = options
    end

    def render
      ERB.new(template).result(binding)
    end

    def template
      File.read(options[:template])
    end

    def resource_tags
      options[:files].collect do |file|
        case File.extname(file)
        when '.js'
          %{<script src="#{file}" type="text/javascript"></script>}
        when '.css'
          %{<link rel="stylesheet" href="#{file}" type="text/css" />}
        else
          raise FileTypeError.new("Unknown file type: #{File.extname(file)} for #{file}")
        end
      end.join
    end
  end
end

