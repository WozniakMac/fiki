require 'rails_helper'

RSpec.describe 'home/index.html.slim', type: :view do
  it 'display welcome message' do
    render
    expect(rendered).to have_content 'Welcome'
  end
end
