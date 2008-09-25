module Spec # :nodoc:
  module Rails
    module Matchers
			class TableBodyMatcher
				def initialize expected
					@expected = expected
				end
				def matches? response
					@actual = extract_html_content response.body
					@actual == @expected
				end
				def failure_message
					"\nWrong #{@element_name} contents.\nexpected: #{@expected.inspect}\n   found: #{@actual.inspect}\n\n"
				end
				def extract_html_content html
					doc = Hpricot.XML(html)
					elements = doc.search('/table/tr')
					elements.map{|n| n.search('/td').map{|n| n.inner_text.strip.gsub(/\n    \t\t/, "\n")}}
				end
			end
		end
	end
end