module Flowerbox::Delivery::Tilt::TemplateThatSaves
  def prepare ; end

  def handle_evaluate
    case File.extname(file)
    when '.js'
      file
    else
      save
    end
  end

  def save
    FileUtils.mkdir_p File.dirname(temp_file)
    File.open(temp_file, 'wb') { |fh| fh.print data }

    temp_file
  end

  def temp_file
    File.join(Dir.pwd, ".tmp/sprockets", file.gsub(%r{(\.#{self.class::EXTENSION})(.*)$}, '\1'))
  end
end

