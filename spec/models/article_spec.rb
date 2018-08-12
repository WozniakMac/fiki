require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'when article has correct params' do
    it 'is invalid' do
      article = build(:article)
      expect(article.valid?).to be true
    end
  end

  context 'when article has empty title' do
    it 'is invalid' do
      article = build(:article, title: nil)
      expect(article.valid?).to be false
    end
  end

  context 'when article has empty user_id' do
    it 'is invalid' do
      article = build(:article, user_id: nil)
      expect(article.valid?).to be false
    end
  end

  context 'when article has empty content' do
    it 'is invalid' do
      article = build(:article, content: nil)
      expect(article.valid?).to be false
    end
  end
end
