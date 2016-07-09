require "json_to_ruby_class/version"

module JsonToRubyClass
  def self.produce_models(hash)
    models_array = collect_info_from_json(hash, nil)
    prepare_models_from_hash models_array
  end

  #######
  private
  #######

  def self.collect_info_from_json(hash, model_name, existing_models_array = [])
    accessors = []

    hash.each do |key, value|
      # In some cases you have a parent called Resources and inside has an array of models Resource
      constructed_model_name = (key.to_s == model_name.to_s ? "#{model_name}_#{key}" : key)

      if value.class == Hash
        collect_info_from_json(value, constructed_model_name, existing_models_array)
      elsif value.class == Array
        value.each do |array_element|
          collect_info_from_json(array_element, constructed_model_name, existing_models_array)
        end
      end

      accessors << key
    end

    model_name_to_be_used = (model_name.nil? ? 'Example' : model_name.to_s.camelcase)
    accessors_to_be_used = accessors.map { |s| ":#{s.to_s.underscore}" }

    if (hash = existing_models_array.find { |model| model[:name] == model_name_to_be_used })
      hash[:accessors].push(accessors_to_be_used).flatten!.uniq!
    else
      existing_models_array << {
          :name => (model_name.nil? ? 'Example' : model_name.to_s.camelcase),
          :accessors => accessors_to_be_used
      }
    end

    existing_models_array
  end

  def self.prepare_models_from_hash(models_array)
    model_string = ''

    models_array.each do |model|
      model_string << "Class #{model[:name].singularize}\n"
      model_string << '   attr_accessor '
      model_string << model[:accessors].join(",\n                 ")
      model_string << "\nend\n\n"
    end

    model_string
  end
end