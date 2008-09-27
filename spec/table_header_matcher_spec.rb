require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'table_header_matcher' do
	describe 'with <thead> element' do
		it 'should find headers' do
			verify_table_header_match 'my_id', '<table id="my_id"><thead><tr><th>h1</th><th>h2</th></tr></thead></table>', [['h1', 'h2']]
		end
	end

	describe 'without <thead> element' do
		it 'should not require <thead>' do
			verify_table_header_match 'my_id', '<table id="my_id"><tr><th>h1</th><th>h2</th></tr></table>', [['h1', 'h2']]
		end

		it 'should ignore regular row' do
			verify_table_header_match 'my_id', '<table id="my_id"><tr><th>h1</th><th>h2</th></tr><tr><td>"regular"</td><td>"row"</td></tr></table>', [['h1', 'h2']]
		end

		it 'should handle multiple header rows' do
			verify_table_header_match 'my_id', '<table id="my_id"><tr><th>h1</th><th>h2</th></tr><tr><th>h3</th><th>h4</th></tr><tr><td>"regular"</td><td>"row"</td></tr></table>', [['h1', 'h2'], ['h3', 'h4']]
		end
	end

	private

	def verify_table_header_match id, html, expected
		response = mock_model Object, :body => html
		response.should have_table_header(id, expected)
	end
end