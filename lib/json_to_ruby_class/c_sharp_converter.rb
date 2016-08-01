module JsonToRubyClass
  class CSharpConverter
    #######
    private
    #######

    def self.prepare_c_sharp_models_from_hash(models_array)
      model_string = ''

      models_array.each do |model|
        model_string << "public class #{model[:name].singularize}\n"
        model_string << "{\n"

        model[:accessors].each do |accessor|
          type = case accessor[:type].to_s
                   when 'String' then 'string'
                   when 'Fixnum' then 'int'
                   when 'Float' then 'decimal'
                   when 'Array' then "#{accessor[:key].singularize.camelcase}[]"
                   when 'TrueClass' then 'bool'
                   when 'FalseClass' then 'bool'
                   when 'Hash' then "#{accessor[:key].singularize.camelcase}"
                   #   TODO: How could you cover an array of integers?
                   else accessor[:type].to_s
                 end

          model_string << "   public #{type} #{accessor[:key]} { get; set; }\n"
        end
        model_string << "}\n\n"
      end

      model_string
    end
  end
end