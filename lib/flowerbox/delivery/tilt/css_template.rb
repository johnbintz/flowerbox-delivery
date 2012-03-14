require 'tilt'

class Flowerbox::Delivery::Tilt::CSSTemplate < Tilt::Template
  self.default_mime_type = "text/css"

  EXTENSION = "css"

  include Flowerbox::Delivery::Tilt::TemplateThatSaves

end

