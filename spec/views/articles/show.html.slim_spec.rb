require 'rails_helper'

RSpec.describe 'articles/show', type: :view do
  before do
    @article = assign(:article, Article.create!(
                                  title: 'Title',
                                  language: 'Language',
                                  content: 'MyText',
                                  user: create(:user)
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Language/)
    expect(rendered).to match(/MyText/)
  end
end
