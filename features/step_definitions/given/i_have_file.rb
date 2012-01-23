Given /^I have the file "([^"]*)" with the content:$/ do |filename, string|
  FileUtils.mkdir_p File.dirname(filename)

  File.open(filename, 'wb') { |fh| fh.print(string) }
end
