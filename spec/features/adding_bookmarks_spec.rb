feature 'Adding bookmarks' do
  scenario 'A user can Add bookmarks, return title' do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data


    visit('/bookmarks')
    fill_in :bookmark, with: 'https://en.wiki.sureai.net/Enderal:Phasmalism'
    fill_in :title, with: 'Enderal'
    click_button('Add Bookmark')

    expect(page).to have_content "Enderal"
  end
end
