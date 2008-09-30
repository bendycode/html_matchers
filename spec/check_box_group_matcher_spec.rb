require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'check_box_group_matcher' do
	it 'should find matching check box group' do
		response = mock_model(Object, :body => check_box_html)
		response.should have_check_box_group('user[genre_ids][]', [['1', 'Rock/Pop General'], ['2', 'Modern "Alternative"'], ['4', 'Metal']])
	end

	private

	def check_box_html
		%{<div>
		  <input id="genre_1" name="user[genre_ids][]" type="checkbox" value="1" />
		  <label for="genre_1">Rock/Pop General</label>
		</div>

		<div>
		  <input id="genre_2" name="user[genre_ids][]" type="checkbox" value="2" />
		  <label for="genre_2">Modern "Alternative"</label>
		</div>

		<div>
		  <input id="genre_4" name="user[genre_ids][]" type="checkbox" value="4" />
		  <label for="genre_4">Metal</label>
		</div>}
	end
end