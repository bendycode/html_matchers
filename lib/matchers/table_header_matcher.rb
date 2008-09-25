module Spec # :nodoc:
  module Rails
    module Matchers
			class TableHeaderMatcher
				def initialize table_id, expected
					@table_id = table_id
					@expected = expected
				end
				def matches? response
					# puts "\n\n\n#{response.body}\n\n\n"
					@actual = extract_html_content response.body
					@actual == @expected
				end
				def failure_message
					"\nWrong table header contents.\nexpected: #{@expected.inspect}\n   found: #{@actual.inspect}\n\n"
				end
				def extract_html_content html
					doc = Hpricot.XML(html)
					puts "Missing table with id: #{@table_id}" if doc.search("table##{@table_id}").empty?
					elements = doc.search("table##{@table_id}/thead/tr")
					elements.map{|n| n.search('/th').map{|n| n.inner_text.strip.gsub(/\n    \t\t/, "\n")}}
				end
			end
		end
	end
end