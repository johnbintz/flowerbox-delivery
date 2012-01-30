module Flowerbox::Delivery
  class UniqueAssetList < ::Array
    def add(files)
      [ files ].flatten.each { |file| self << file if !include?(file) }
    end

    private
    def include?(file)
      any? { |other_file| other_file == file }
    end
  end
end

