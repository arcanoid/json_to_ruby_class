require "json_to_ruby_class/version"
require "json_to_ruby_class/ruby_converter"
require "json_to_ruby_class/c_sharp_converter"
require "json_to_ruby_class/vb_dot_net_converter"
require 'active_support'
require 'active_support/core_ext'

module JsonToRubyClass
  VB_DOT_NET_LANGUAGE_TYPE = 'vb'
  C_SHARP_LANGUAGE_TYPE = 'c#'
  RUBY_LANGUAGE_TYPE = 'ruby'

  def self.produce_models(hash, language = 'ruby')
    models_array = collect_info_from_json(hash, nil)

    case language
     when C_SHARP_LANGUAGE_TYPE then CSharpConverter.prepare_c_sharp_models_from_hash models_array
     when VB_DOT_NET_LANGUAGE_TYPE then VBDotNetConverter.prepare_vb_dot_net_models_from_hash models_array
     else RubyConverter.prepare_ruby_models_from_hash models_array
    end
  end

  #######
  private
  #######

  def self.collect_info_from_json(hash, model_name, existing_models_array = [])
    unless hash.is_a? Hash
      hash = ActiveSupport::JSON.decode(hash)
    end
    accessors = []

    hash.each do |key, value|
      # In some cases you have a parent called Resources and inside has an array of models Resource
      constructed_model_name = (key.to_s == model_name.to_s ? "#{model_name}_#{key}" : key)

      if value.class == Hash
        collect_info_from_json(value, constructed_model_name, existing_models_array)
      elsif value.class == Array
        value.each do |array_element|
          if array_element.class == Hash || array_element.class == Array
            collect_info_from_json(array_element, constructed_model_name, existing_models_array)
          end
        end
      end

      accessors << { :key => "#{key.to_s}", :type => value.class }
    end

    model_name_to_be_used = (model_name.nil? ? 'Example' : model_name.to_s.camelcase)

    if (hash = existing_models_array.find { |model| model[:name] == model_name_to_be_used })
      hash[:accessors].push(accessors).flatten!.uniq!
    else
      existing_models_array << {
          :name => (model_name.nil? ? 'Example' : model_name.to_s.camelcase),
          :accessors => accessors
      }
    end

    existing_models_array
  end
end
