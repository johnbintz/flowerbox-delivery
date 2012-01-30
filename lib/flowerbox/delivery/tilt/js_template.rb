require 'tilt'

class Flowerbox::Delivery::Tilt::JSTemplate < Tilt::Template
  self.default_mime_type = "application/javascript"

  def prepare ; end

  def evaluate(scope, locals, &block)
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
    File.join(Dir.pwd, ".tmp/sprockets", file.gsub(%r{(\.js)(.*)$}, '\1'))
  end
end

