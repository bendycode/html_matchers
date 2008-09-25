module Spec # :nodoc:
  module Rails
    module Matchers
			class DropDownMatcher
				def initialize target_id, expected
					@xpath = "select##{target_id}/option"
					@expected = expected
				end
				def matches? response
					@actual = extract_html_content response.body
					@actual == @expected
				end
				def failure_message
					"\nWrong drop down contents.\nexpected: #{@expected.inspect}\n   found: #{@actual.inspect}\n\n"
				end
				def extract_html_content html
					doc = Hpricot.XML(html)
					doc.search(@xpath).map{|n| n.inner_text.strip}
				end
			end
		end
	end
end