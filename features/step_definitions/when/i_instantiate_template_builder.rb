When /^I instantiate a template renderer with the template "([^"]*)" and the files:$/ do |template, table|
  @template_renderer = Flowerbox::Delivery::TemplateRenderer.new(:files => table.raw.collect(&:first), :template => template)
end
