require 'rails_helper'

RSpec.describe Dropbox::LinkBuilder, type: :service do
  context "link" do
    let(:uid) { "32196928" }
    let(:file) { "/public/spec/factories/markdown.md" }

    it "should be correctly build" do
      link = Dropbox::LinkBuilder.new uid, file
      expect(link.execute).to eq("https://dl.dropboxusercontent.com/u/32196928/spec/factories/markdown.md")
    end
  end
end
