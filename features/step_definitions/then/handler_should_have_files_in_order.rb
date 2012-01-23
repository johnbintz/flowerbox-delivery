Then /^the handler should have the following files in order:$/ do |table|
  table.raw.collect(&:first).each_with_index do |path, index|
    @sprockets.files[index].should == Pathname(File.expand_path(path))
  end
end

