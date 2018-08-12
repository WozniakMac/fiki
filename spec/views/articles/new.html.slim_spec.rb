require 'rails_helper'

RSpec.describe 'articles/new', type: :view do
  before do
    assign(:article, Article.new(
                       title: 'MyString',
                       language: 'MyString',
                       content: 'MyText',
                       user: create(:user)
    ))
  end

  it 'renders new article form' do
    render

    assert_select 'form[action=?][method=?]', articles_path, 'post' do
      assert_select 'input[name=?]', 'article[title]'
      assert_select 'input[name=?]', 'article[language]'
      assert_select 'textarea[name=?]', 'article[content]'
    end
  end
end
