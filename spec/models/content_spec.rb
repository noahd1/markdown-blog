require 'rails_helper'

RSpec.describe Content, type: :model do
  context "content" do
    let(:content) { create(:content) }

    it "should return slug as param" do
      expect(content.to_param).to eq content.slug
    end
  end
end
