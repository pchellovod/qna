require_relative '../acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As on authenticated user
  I want to be able to ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text question'
    click_on 'Create'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text question'
    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-authenticated user ties to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Authenticated user create question with invalid attributes' do
    sign_in(user)
    visit root_path
    click_on 'Ask question'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_on 'Create'
    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "Title can't be blank"
  end
end
