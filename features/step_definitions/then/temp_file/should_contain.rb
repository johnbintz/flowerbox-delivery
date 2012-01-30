Then /^the temp file should contain:$/ do |string|
  file_lines = File.read(@temp_file_path).lines.collect(&:strip)

  string.lines.each do |line|
    file_lines.should include(line.strip)
  end
end
