Then /^the evaluated template should be the path to the temp file for "([^"]*)"$/ do |file|
  @temp_file_path.should == @result
end
