require 'hpricot'
%w(drop_down radio_group span_text table_body table_header td_link).each do |element|
	require File.join(File.dirname(__FILE__), 'matchers', "#{element}_matcher")
end

module Spec # :nodoc:
  module Rails
    module Matchers

			def have_dropdown target_id, expected_options
				DropDownMatcher.new target_id, expected_options
			end

			def have_radio_group target_name, expected_radio_choices
				RadioGroupMatcher.new target_name, expected_radio_choices
			end

			def have_span_text target_id, expected_text
				SpanTextMatcher.new target_id, expected_text
			end

			def have_table_header table_id, expected
				TableHeaderMatcher.new table_id, expected
			end

			def have_table_body table_id, expected
				TableBodyMatcher.new table_id, expected
			end
			
			def have_td_link target_id, expected_link, expected_text
				TdLinkMatcher.new target_id, expected_link, expected_text
			end
		end
	end
end