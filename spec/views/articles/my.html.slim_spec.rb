require 'rails_helper'

RSpec.describe 'articles/my', type: :view do
  let(:user) { create(:user) }

  before do
    assign(:articles, [
             Article.create!(
               title: 'Title',
               language: 'Language',
               content: 'MyText',
               user: user
             ),
             Article.create!(
               title: 'Title',
               language: 'Language',
               content: 'MyText',
               user: user
             )
           ])
  end

  it 'renders a list of articles' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Language'.to_s, count: 2
  end
end
