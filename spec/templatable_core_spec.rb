# encoding: utf-8
require 'spec_helper'
require 'templatable_core'

describe Templatable::Core do

  context :init do
    OUTPUT_DSL_TMP_DIR = 'generate_dsl'
    cases = [
      {
        case_no: 1,
        case_title: 'valid case',
        expected_file: Templatable::Core::TEMPLATABLE_FILE,
        expected_content: Templatable::Core::TEMPLATABLE_TEMPLATE,
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          templatable_core = Templatable::Core.new

          # -- when --
          templatable_core.init

          # -- then --
          actual = File.read("./#{c[:expected_file]}")
          expect(actual).to eq(c[:expected_content])
        ensure
          case_after c
        end
      end

      def case_before(c)
        Dir.mkdir(OUTPUT_DSL_TMP_DIR) unless Dir.exist? OUTPUT_DSL_TMP_DIR
        Dir.chdir(OUTPUT_DSL_TMP_DIR)
      end

      def case_after(c)
        Dir.chdir('../')
        FileUtils.rm_rf(OUTPUT_DSL_TMP_DIR) if Dir.exist? OUTPUT_DSL_TMP_DIR
      end
    end
  end

  context :execute do
    OUTPUT_TEMPLATABLE_TMP_DIR = 'tmp_templatable'
    TEMPLATABLE_CASE1 = <<-EOF
# encoding: utf-8
output_fullpath "./sample_use.rb"

class_name "sample_use"

TEMPLATE =<<-EOS
line1:<%=param1%>
line2:<%=param2%>
EOS

template TEMPLATE

placeholders ["param1", "param2"]
    EOF

    RESULT_CASE1 = <<-EOF
# encoding: utf-8
require 'templatable'

class SampleUse
  include Templatable
  template <<-EOS
line1:<%=placeholders[:param1]%>
line2:<%=placeholders[:param2]%>
  EOS

  def manufactured_param1
    # TODO: implement your logic
  end

  def manufactured_param2
    # TODO: implement your logic
  end
end
    EOF

    cases = [
      {
        case_no: 1,
        case_title: 'valid case',
        output_file: 'sample_use.rb',
        templatablefile: TEMPLATABLE_CASE1,
        expected: RESULT_CASE1,
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          templatable_core = Templatable::Core.new

          # -- when --
          templatable_core.execute

          # -- then --
          actual_exists = File.exist? c[:output_file]
          expect(actual_exists).to be_true
          actual_contents = File.read c[:output_file]
          expect(actual_contents).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        Dir.mkdir(OUTPUT_TEMPLATABLE_TMP_DIR) unless Dir.exist? OUTPUT_TEMPLATABLE_TMP_DIR
        Dir.chdir(OUTPUT_TEMPLATABLE_TMP_DIR)
        File.open(Templatable::Core::TEMPLATABLE_FILE, 'w') { |f|f.print c[:templatablefile] }
      end

      def case_after(c)
        Dir.chdir('../')
        FileUtils.rm_rf(OUTPUT_TEMPLATABLE_TMP_DIR) if Dir.exist? OUTPUT_TEMPLATABLE_TMP_DIR
      end
    end
  end
end
