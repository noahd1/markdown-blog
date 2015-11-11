require 'rails_helper'

RSpec.describe ArticleProvider, type: :service do
  context "with given file" do
    let(:article_provier) { ArticleProvider.new "/var/www/html/spec/factories/markdown.md" }

    it "should return a filename" do
      article = article_provier.execute
      expect(article.filename).to eq("markdown")
    end

    it "should return markdown" do
      article = article_provier.execute
      expect(article.markdown).to_not be_empty
    end

    it "should return html" do
      article = article_provier.execute
      expect(article.content).to eq("<h1>Demo headline</h1>\n\n<p>Some content</p>\n")
    end

    it "should return a title" do
      article = article_provier.execute
      expect(article.title).to eq("Some title")
    end

    it "should return an author" do
      article = article_provier.execute
      expect(article.author).to eq("Marvin Caspar")
    end

    it "should return tags" do
      article = article_provier.execute
      expect(article.tags).to eq([
        Tag.find_by(title: "test"),
        Tag.find_by(title: "demo")
      ])
    end
  end

  context "without a file" do
    let(:article_provier) { ArticleProvider.new "" }

    it "should throw an execption" do
      expect{ article_provier.execute }.to raise_error(RuntimeError)
    end
  end
end
