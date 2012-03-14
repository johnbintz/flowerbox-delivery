require 'tilt'

class Flowerbox::Delivery::Tilt::JSTemplate < Tilt::Template
  self.default_mime_type = "application/javascript"

  EXTENSION = "js"

  include Flowerbox::Delivery::Tilt::TemplateThatSaves

  def evaluate(scope, locals, &block)
    handle_evaluate
  end
end

