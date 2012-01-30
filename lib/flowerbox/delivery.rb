module Flowerbox
  module Delivery
    autoload :Server, 'flowerbox/delivery/server'
    autoload :TemplateRenderer, 'flowerbox/delivery/template_renderer'
    autoload :SprocketsHandler, 'flowerbox/delivery/sprockets_handler'
    autoload :UniqueAssetList, 'flowerbox/delivery/unique_asset_list'

    autoload :Tilt, 'flowerbox/delivery/tilt'
  end
end

