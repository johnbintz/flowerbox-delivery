Given /^I have a server with the configuration:$/ do |table|
  options = {}

  table.rows_hash.each do |key, value|
    options[key.to_sym] = value
  end

  @server = Flowerbox::Delivery::Server.new(options)
end
