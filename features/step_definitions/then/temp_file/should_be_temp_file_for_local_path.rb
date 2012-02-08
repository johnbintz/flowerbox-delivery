Then /^there should be a temp file for the local path "([^"]*)"$/ do |path|
  parts = path.split('.')[0..1].join('.')

  @temp_file_path = Dir[".tmp/**/#{parts}"].first

  @temp_file_path.should_not be_nil
end
