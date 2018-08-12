require 'rails_helper'

RSpec.describe 'articles/edit', type: :view do
  before do
    @article = assign(:article, Article.create!(
                                  title: 'MyString',
                                  language: 'MyString',
                                  content: 'MyText',
                                  user: create(:user)
    ))
  end

  it 'renders the edit article form' do
    render
    assert_select 'form[action=?][method=?]', article_path(@article), 'post' do
      assert_select 'input[name=?]', 'article[title]'
      assert_select 'input[name=?]', 'article[language]'
      assert_select 'textarea[name=?]', 'article[content]'
    end
  end
end
