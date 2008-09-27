require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'table_header_matcher' do
	describe 'with <thead> element' do
		it 'should have headers' do
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

	describe 'passed wrong id' do
		it 'should not have header' do
			verify_no_header_match 'wrong_id', '<table id="my_id"><tr><th>h1</th><th>h2</th></tr></table>', [['h1', 'h2']]
		end
	end

	describe 'passed wrong expected' do
		it 'should not match' do
			verify_no_header_match 'my_id', '<table id="my_id"><tr><th>h1</th><th>h2</th></tr></table>', [['ha', 'hb']]
		end
	end

	describe 'with normal failure' do
		before(:each) do
				@response = mock_model Object, :body => 'Some non-matching HTML'
		end

		it 'should raise ExpectationNotMetError' do
			lambda{ @response.should have_table_header('id', [['h1', 'h2']]) }.should raise_error(Spec::Expectations::ExpectationNotMetError)
		end

		it 'should have correct failure message' do
			begin
				@response.should have_table_header('id', [['h1', 'h2']])
			rescue Spec::Expectations::ExpectationNotMetError => e
				e.to_s.should == "\nWrong table header contents.\nexpected: [[\"h1\", \"h2\"]]\n   found: []\n\n"
			end
		end
	end

	describe 'with negative failure' do
		before(:each) do
				@response = mock_model Object, :body => '<table id="my_id"><tr><th>h1</th><th>h2</th></tr></table>'
		end

		it 'should raise ExpectationNotMetError' do
			lambda{ @response.should_not have_table_header('my_id', [['h1', 'h2']]) }.should raise_error #(Spec::Expectations::ExpectationNotMetError)
		end

		it 'should have correct negative failure message' do
			begin
				@response.should_not have_table_header('my_id', [['h1', 'h2']])
			rescue Spec::Expectations::ExpectationNotMetError => e
				e.to_s.should == "\nTable header should not have contained: [[\"h1\", \"h2\"]]\n"
			end
		end
	end

	private

	def verify_table_header_match id, html, expected
		response = mock_model Object, :body => html
		response.should have_table_header(id, expected)
	end

	def verify_no_header_match id, html, expected
		response = mock_model Object, :body => html
		response.should_not have_table_header(id, expected)
	end
end