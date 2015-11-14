require 'rails_helper'

RSpec.describe ContentProvider, type: :service do
  context "with given file" do
    let(:content_provier) { ContentProvider.new "/var/www/html/spec/factories/markdown.md" }

    it "should return a filename" do
      content = content_provier.execute
      expect(content.filename).to eq("markdown")
    end

    it "should return markdown" do
      content = content_provier.execute
      expect(content.markdown).to_not be_empty
    end

    it "should return html" do
      content = content_provier.execute
      expect(content.content).to eq("<h1>Demo headline</h1>\n\n<p>Some content</p>\n")
    end

    it "should return a title" do
      content = content_provier.execute
      expect(content.title).to eq("Some title")
    end

    it "should return an author" do
      content = content_provier.execute
      expect(content.author).to eq("Marvin Caspar")
    end

    it "should return tags" do
      content = content_provier.execute
      expect(content.tags).to eq([
        Tag.find_by(title: "test"),
        Tag.find_by(title: "demo")
      ])
    end
  end

  context "without a file" do
    let(:content_provier) { ContentProvider.new "" }

    it "should throw an execption" do
      expect{ content_provier.execute }.to raise_error(RuntimeError)
    end
  end
end
