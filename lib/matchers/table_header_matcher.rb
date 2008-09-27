module Spec # :nodoc:
  module Rails
    module Matchers
			class TableHeaderMatcher
				def initialize table_id, expected
					@table_id = table_id
					@expected = expected
				end

				def matches? response
					@actual = extract_html_content response.body
					@actual == @expected
				end

				def failure_message
					"\nWrong table header contents.\nexpected: #{@expected.inspect}\n   found: #{@actual.inspect}\n\n"
				end

				def negative_failure_message
					"\nTable header should not have contained: #{@expected.inspect}\n"
				end

				def extract_html_content html
					doc = Hpricot.XML(html)
					elements = doc.search("table##{@table_id} tr").select{|e| ! e.search('th').empty? }
					elements.map{|n| n.search('/th').map{|n| n.inner_text.strip.gsub(/\n    \t\t/, "\n")}}
				end
			end
		end
	end
end