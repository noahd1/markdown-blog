require 'rails_helper'

RSpec.describe Article, type: :model do
  context "article" do
    let(:article) { create(:article) }

    it "should return slug as param" do
      expect(article.to_param).to eq article.slug
    end
  end
end
