module Spec # :nodoc:
  module Rails
    module Matchers
			class TableBodyMatcher
				def initialize table_id_or_expected, expected
					case table_id_or_expected
					when String
						@table_id = table_id_or_expected
						@expected = expected
					when Array
						@expected = table_id_or_expected
					end
				end
				def matches? response
					@actual = extract_html_content response.body
					@actual == @expected
				end
				def failure_message
					"\nWrong #{@element_name} contents.\nexpected: #{@expected.inspect}\n   found: #{@actual.inspect}\n\n"
				end
				def negative_failure_message
					"\nShould not have matched #{@expected.inspect}.\n\n"
				end
				def extract_html_content html
					doc = Hpricot.XML(html)
					elements = doc.search("table#{"##{@table_id}" if @table_id} tr").select{|e| ! e.search('td').empty? }
					elements.map{|n| n.search('/td').map{|n| n.inner_text.strip.gsub(/\n    \t\t/, "\n")}}
				end
			end
		end
	end
end