require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'table_header_matcher' do
	it 'should find headers' do
		response = mock_model(Object, :body => '<table id="my_id"><thead><tr><th>h1</th><th>h2</th></tr></thead></table>')
		response.should have_table_header('my_id', [['h1', 'h2']])
	end
end