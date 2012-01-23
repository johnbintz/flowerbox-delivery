require 'nokogiri'

Then /^I should have script tags for the following files in the template:$/ do |table|
  doc = Nokogiri::XML(@result)

  table.raw.collect(&:first).each do |file|
    doc.at_css("script[src='#{file}']").should_not be_nil
  end
end
