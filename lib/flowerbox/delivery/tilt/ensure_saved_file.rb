require 'tilt'

module Flowerbox::Delivery::Tilt
  class EnsureSavedFile < Tilt::Template
    include TemplateThatSaves

    def handle_evaluate
      output = if File.file?(data)
        data
      else
        save
      end

      output
    end

    def extension
      "js"
    end
  end
end

