# encoding: utf-8
require 'active_model'

module Templatable
  class DslModel
    include ActiveModel::Model

    # output_fullpath
    attr_accessor :output_fullpath
    validates :output_fullpath, :presence => true

    # class_name
    attr_accessor :class_name
    validates :class_name, :presence => true

    # template
    attr_accessor :template
    validates :template, :presence => true

    # placeholders
    attr_accessor :placeholders
    validates :placeholders, :presence => true

  end
end
