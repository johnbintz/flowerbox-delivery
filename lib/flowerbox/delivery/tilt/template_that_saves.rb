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
    File.join(Dir.pwd, ".tmp/sprockets", file.gsub(%r{(\.#{extension})(.*)$}, '\1'))
  end

  def evaluate(scope, locals, &block)
    handle_evaluate
  end

  def extension
    self.class::EXTENSION
  end
end

