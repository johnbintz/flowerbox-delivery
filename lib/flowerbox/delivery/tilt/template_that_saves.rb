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
    File.open(temp_file, 'wb') { |fh| fh.print data_to_save }

    temp_file
  end

  def data_to_save
    data
  end

  def temp_file
    File.join(Dir.pwd, ".tmp/sprockets", file.gsub(%r{(\.#{extension})(.*)$}, '\1'))
  end

  def extension
    self.class::EXTENSION
  end

  def evaluate(scope, locals, &block)
    handle_evaluate
  end
end

