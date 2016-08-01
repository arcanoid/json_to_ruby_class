module JsonToRubyClass
  class VBDotNetConverter
    #######
    private
    #######

    def self.prepare_vb_dot_net_models_from_hash(models_array)
      model_string = ''

      models_array.each do |model|
        model_string << "Public Class #{model[:name].singularize}\n"

        model[:accessors].each do |accessor|
          type = case accessor[:type].to_s
                   when 'String' then 'String'
                   when 'Fixnum' then 'Integer'
                   when 'Float' then 'Decimal'
                   when 'Array' then "#{accessor[:key].singularize.camelcase}()"
                   when 'TrueClass' then 'Boolean'
                   when 'FalseClass' then 'Boolean'
                   when 'Hash' then "#{accessor[:key].singularize.camelcase}"
                   #   TODO: How could you cover an array of integers?
                   else accessor[:type].to_s
                 end

          model_string << "   Public Property #{accessor[:key]} As #{type}\n"
        end
        model_string << "End Class\n\n"
      end

      model_string
    end
  end
end