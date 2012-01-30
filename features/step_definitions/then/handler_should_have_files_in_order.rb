require 'erb'

Then /^the handler should have the following files in order:$/ do |table|
  table.raw.flatten.each_with_index do |path, index|
    path = ERB.new(path).result(binding)

    @sprockets.files[index].should == Pathname(File.expand_path(path))
  end
end

