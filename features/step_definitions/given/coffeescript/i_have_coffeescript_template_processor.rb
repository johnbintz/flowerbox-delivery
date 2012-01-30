Given /^I have a CoffeeScript template processor for the file "([^"]*)"$/ do |file|
  @template_processor = Flowerbox::Delivery::Tilt::CoffeeTemplate.new(file)
end
