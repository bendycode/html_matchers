module Spec # :nodoc:
  module Rails
    module Matchers
			class SpanTextMatcher
				def initialize target_id, expected_text
					@xpath = "p span##{target_id}"
					@expected = expected_text
				end
				def matches? response
					@actual = extract_html_content response.body
					@actual == @expected
				end
				def failure_message
					"\nWrong span text contents.\nexpected: #{@expected.inspect}\n   found: #{@actual.inspect}\n\n"
				end
				def extract_html_content html
					doc = Hpricot.XML(html)
					elements = doc.search(@xpath)
					elements.map{|n| n.inner_text.strip}.first
				end
			end
		end
	end
end