module JsonToRubyClass
  class RubyConverter
    #######
    private
    #######

    def self.prepare_ruby_models_from_hash(models_array)
      model_string = ''

      models_array.each do |model|
        model_string << "class #{model[:name].singularize}\n"
        model_string << '   attr_accessor '
        model_string << model[:accessors].map { |accessor| ":#{accessor[:key].underscore}" }.join(",\n                 ")
        model_string << "\nend\n\n"
      end

      model_string
    end
  end
end