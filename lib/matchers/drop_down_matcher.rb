module Spec # :nodoc:
  module Rails
    module Matchers
			class DropDownMatcher
				def initialize target_id, expected
					@target_id = target_id
					@expected = expected
				end

				def matches? response
					@actual = extract_html_content response.body
					@actual == @expected
				end

				def failure_message
					"\nWrong drop down contents.\nexpected: #{@expected.inspect}\n   found: #{@actual.inspect}\n\n"
				end

				def negative_failure_message
					"\nShould not have matched dropdown with id: #{@target_id}\n\tand contents: #{@expected.inspect}\n\n"
				end

				def extract_html_content html
					doc = Hpricot.XML(html)
					doc.search("select##{@target_id}/option").map{|n| n.inner_text.strip}
				end
			end
		end
	end
end