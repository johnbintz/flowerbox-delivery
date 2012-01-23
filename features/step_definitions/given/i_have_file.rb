Given /^I have the file "([^"]*)" with the content:$/ do |filename, string|
  File.open(filename, 'wb') { |fh| fh.print(string) }
end
