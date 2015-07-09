require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  
  describe 'Comments' do
  	
    let(:user) {FactoryGirl.create(:user)}
	let(:post) {FactoryGirl.create(:post)}    	

    it 'create comment' do
    	visit post_path(post)  
		
		expect(page).to have_link 'Back'
	end

  end
end
