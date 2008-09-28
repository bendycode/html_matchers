require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'drop_down_matcher' do
	it 'should find matching dropdown' do
		response = mock_model(Object, :body => '<select id="choice"><option value="val1">Choice 1</option><option value="val2">Choice 2</option></select>')
		response.should have_dropdown('choice', ['Choice 1', 'Choice 2'])
	end

	describe 'passed wrong id' do
		it 'should not match' do
			response = mock_model(Object, :body => '<select id="choice"><option value="val1">Choice 1</option><option value="val2">Choice 2</option></select>')
			response.should_not have_dropdown('wrong_id', ['Choice 1', 'Choice 2'])
		end
	end
end