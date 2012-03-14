require 'tilt'

class Flowerbox::Delivery::Tilt::JSTTemplate < Sprockets::JstProcessor
  EXTENSION = "jst"

  include Flowerbox::Delivery::Tilt::TemplateThatSaves

  def evaluate(scope, locals, &block)
    @data = super

    p @data

    handle_evaluate
  end

  def data_to_save
    @data || data
  end
end

