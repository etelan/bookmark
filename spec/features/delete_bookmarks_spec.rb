feature 'Deleting bookmarks' do
  scenario 'A user can delete bookmarks' do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Add the test data


    visit('/bookmarks')
    fill_in :bookmark, with: 'https://en.wiki.sureai.net/Enderal:Phasmalism'
    fill_in :title, with: 'Enderal'
    click_button('Add Bookmark')

    click_button("🗑")

    expect(page).not_to have_content "Enderal"
  end
end
