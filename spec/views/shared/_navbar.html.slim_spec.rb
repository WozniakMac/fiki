require 'rails_helper'

RSpec.describe 'shared/_navbar.html.slim', type: :view do
  context 'when user signed in' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
    end

    it 'display SignOut button' do
      render
      expect(rendered).to match(/SignOut/)
    end
  end

  context 'when user not signed in' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end

    it 'display SignIn button' do
      render
      expect(rendered).to match(/SignIn/)
    end
  end
end
