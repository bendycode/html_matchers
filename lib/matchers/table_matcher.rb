module Spec # :nodoc:
  module Rails
    module Matchers
      class TableMatcher

        def initialize table_id_or_expected, expected
          case table_id_or_expected
          when String
            @table_id = table_id_or_expected
            @expected = expected
          when Array
            @expected = table_id_or_expected
          end
          raise 'Invalid "expected" argument' if @expected.nil?
        end

        def matches? response
          @actual = extract_html_content response.body
          @actual == @expected
        end

        def failure_message
          "\nWrong table contents.\nexpected: #{@expected.inspect.gsub('], [', "],\n[")}\n   found: #{@actual.inspect.gsub('], [', "],\n[")}\n\n"
        end

       def negative_failure_message
          "\nTable should not have matched: #{@expected.inspect}\n"
        end

        def extract_html_content html
          doc = Hpricot.XML(html)

          rows = doc.search("table#{"##{@table_id}" if @table_id} tr")
          header_elements = rows.reject{|e| e.search('th').empty? }
          #header_content = header_elements.map{|n| n.search('/th').map{|n| n.inner_text.strip.gsub(/\n[\n \t]*/, "\n")}}
          header_content = header_elements.map{|n| n.search('/th').map{|n| n.inner_text.strip.gsub(/\n    \t\t/, "\n")}}

          body_elements = rows.reject{|e| e.search('td').empty? }
          #body_content = body_elements.map{|n| n.search('/td').map{|n| n.inner_text.strip.gsub(/\n[\n \t]*/, "\n")}}
          body_content = body_elements.map{|n| n.search('/td').map{|n| n.inner_text.strip.gsub(/\n    \t\t/, "\n")}}

          header_content + body_content
        end

      end
    end
  end
end
