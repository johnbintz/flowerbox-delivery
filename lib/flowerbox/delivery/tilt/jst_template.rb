require 'tilt'

class Flowerbox::Delivery::Tilt::JSTTemplate < Sprockets::JstProcessor
  EXTENSION = "jst"

  include Flowerbox::Delivery::Tilt::TemplateThatSaves

  def evaluate(scope, locals, &block)
    super

    handle_evaluate
  end
end

