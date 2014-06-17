# encoding: utf-8
require 'templatable_dsl'
require 'active_support'
require 'erb'

module Templatable
  #  Templatable Core
  class Core
    TEMPLATABLE_FILE = 'Templatablefile'
    TEMPLATABLE_TEMPLATE = <<-EOF
# encoding: utf-8

# output_fullpath
# output_fullpath is required
# output_fullpath allow only String
# output_fullpath's default value => "output_fullpath"
output_fullpath "output_fullpath"

# class_name
# class_name is required
# class_name allow only String
# class_name's default value => "class_name"
class_name "class_name"

TEMPLATE =<<-EOS
TODO: set your template(ERB format)
EOS

# template
# template is required
# template allow only String
# template's default value => "TODO: set your template(ERB format)"
template TEMPLATE

# placeholders
# placeholders is required
# placeholders allow only String-Array
# placeholders's default value => []
placeholders []
    EOF

    CLASS_TEMPLATE = <<-EOF
# encoding: utf-8
require 'templatable'

class <%=class_name%>
  include Templatable
  template <<-EOS
<%=template%>
  EOS

<%=methods%>
end
    EOF

    # generate Templatablefile to current directory.
    def init
      File.open(TEMPLATABLE_FILE, 'w') { |f|f.puts TEMPLATABLE_TEMPLATE }
    end

    # generate TemplateApplayClass
    def execute
      src = read_dsl
      dsl = Templatable::Dsl.new
      dsl.instance_eval src
      template = get_template dsl
      methods = get_methods dsl
      output_src = get_templatable_class_code(dsl.templatable.class_name.camelize, template.chop, methods)
      File.open(dsl.templatable.output_fullpath, 'w:UTF-8') { |f|f.print output_src }
    end

    private

    def read_dsl
      File.open(TEMPLATABLE_FILE) { |f|f.read }
    end

    def get_template(dsl)
      dsl.templatable.template.gsub(/<%=/, "<%=placeholders\[:").gsub(/%>/, "\]%>")
    end

    def get_methods(dsl)
      ret = []
      dsl.templatable.placeholders.each do |placeholder|
        ret << "  def manufactured_#{placeholder}"
        ret << '    # TODO: implement your logic'
        ret << '  end'
        ret << ''
      end
      ret.join("\n").chop
    end

    def get_templatable_class_code(class_name, template, methods)
      erb = ERB.new(CLASS_TEMPLATE)
      erb.result(binding)
    end
  end
end
