Then /^there should be a temp file for the local path "([^"]*)"$/ do |path|
  path.gsub!(%r{\.js.*$}, '.js')

  @temp_file_path = Dir[".tmp/**/#{path}"].first

  @temp_file_path.should_not be_nil
end
