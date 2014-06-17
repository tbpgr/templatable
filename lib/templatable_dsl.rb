# encoding: utf-8
require 'templatable_dsl_model'

module Templatable
  # Dsl
  class Dsl
    attr_accessor :templatable

    # String Define
    [:output_fullpath, :class_name, :template].each do |f|
      define_method f do |value|
        eval "@templatable.#{f} = '#{value}'", binding
      end
    end

    # Array/Hash/Boolean Define
    [:placeholders].each do |f|
      define_method f do |value|
        eval "@templatable.#{f} = #{value}", binding
      end
    end

    def initialize
      @templatable = Templatable::DslModel.new
      @templatable.output_fullpath = 'output_fullpath'
      @templatable.class_name = 'class_name'
      @templatable.template = 'TODO: set your template(ERB format)'
      @templatable.placeholders = []
    end
  end
end
