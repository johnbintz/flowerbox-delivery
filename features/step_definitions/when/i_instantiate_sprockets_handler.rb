When /^I instantiate a Sprockets handler with the following asset directories:$/ do |table|
  @sprockets = Flowerbox::Delivery::SprocketsHandler.new(:asset_paths => table.raw.collect(&:first))
end

