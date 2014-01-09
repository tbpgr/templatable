# Templatable

Templatable is CLI tool that generate ruby-source-code using ERB template.

## Installation

Add this line to your application's Gemfile:

    gem 'templatable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install templatable

## Usage
### before execute
templatable use 'templatable module' that is provided by 'tbpgr_utils' gem.

so, you must install 'tbpgr_utils' gem(=>0.0.5), before use this gem.

### generate Templatablefile
* templatable init

output Templatablefile
~~~ruby
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
~~~

### edit Templatablefile manually
~~~ruby
# encoding: utf-8
output_fullpath "./sample_use.rb"

class_name "sample_use"

TEMPLATE =<<-EOS
line1:<%=param1%>
line2:<%=param2%>
EOS

template TEMPLATE

placeholders ["param1", "param2"]
~~~

### generate templatable class
* templatable execute

sample_use.rb
~~~ruby
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
~~~

### edit your logic
sample_use.rb
~~~ruby
require 'templatable'

class SampleUse
  include Templatable
  template <<-EOS
line1:<%=placeholders[:param1]%>
line2:<%=placeholders[:param2]%>
  EOS

  def manufactured_param1
    "ret1-#{@materials}"
  end

  def manufactured_param2
    "ret2-#{@materials}"
  end
end
~~~

## use your class
~~~ruby
puts SampleUse.new("input").result
~~~

output
~~~
line1:ret1-input
line2:ret2-input
~~~

## Notes
* Templatable output code use 'tbpgr_utils' gem(=>0.0.5).
* if you want to generate RSpec-spec for this class, use 'rspec_piccolo' gem.

## History
* version 0.0.1 : first release.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
