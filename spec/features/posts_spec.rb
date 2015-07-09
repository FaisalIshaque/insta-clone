  require 'rails_helper'

  RSpec.feature "Posts", type: :feature do

    describe 'posts' do

      context 'not logged in' do 

        it 'has no posts' do
          visit '/posts'
          expect(page).to_not have_link 'New'
          expect(page).to have_content 'No posts'
          #expect(page).to have_link 'Edit profile'
          #expect(page).to have_link 'Logout'       
        end 
      end

      context 'logged in' do
        before do
          #apo = create(:user, email: 'nico@nicasdaso.com')
          apo = User.create(email: "a@a.com", password: "12345678", password_confirmation: "12345678")

          login_as apo
          visit posts_path
          click_link 'New'
          attach_file 'Image', Rails.root.join('spec/images/WWJP.png')
          click_button 'Submit'
        end

        it 'create post' do
          expect(page).to have_content "Photo Uploaded"
          expect(page).to have_http_status(:success)
        end
        
        it 'has posts' do
          visit '/posts'
          expect(page).to have_css '.display'
          expect(page).to have_link 'New'
          expect(page).to have_link 'Edit profile'
          expect(page).to have_link 'Logout'
          expect(page).to have_link 'Delete'
        end

        it 'delete post' do
          visit '/posts'
          click_link 'Delete'
          expect(page).to have_content 'Post deleted'
        end
      end

      context 'logged in' do
         before do
          faz = User.create(email: "a@a.com", password: "12345678", password_confirmation: "12345678")
          apo = User.create(email: "b@a.com", password: "12345678", password_confirmation: "12345678")
          login_as apo
          visit posts_path
          click_link 'New'
          attach_file 'Image', Rails.root.join('spec/images/WWJP.png')
          click_button 'Submit'
          
          login_as faz
        end

        it 'cannot delete others post' do
          click_link 'Delete'
          expect(page).to have_content 'This is not your post!'
          expect(page).not_to have_content 'Post deleted'
        end
      end

    end
  end