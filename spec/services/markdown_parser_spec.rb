require 'rails_helper'

RSpec.describe MarkdownParser, type: :service do
  context "markdown only" do
    let(:markdown) { "hello world" }

    it "should have output" do
      parser = MarkdownParser.new markdown
      data = parser.execute
      expect(data.output).to eq("<p>hello world</p>\n")
    end

    it "should not have metadata" do
      parser = MarkdownParser.new markdown
      data = parser.execute
      expect(data.metadata).to be_empty
    end
  end

  context "markdown with metadata" do
    text = <<-MARKDOWN
---
key: "value"
---
hello world
    MARKDOWN

    let(:markdown) { text }

    it "should have output" do
      parser = MarkdownParser.new markdown
      data = parser.execute
      expect(data.output).to eq("<p>hello world</p>\n")
    end

    it "should have metadata" do
      parser = MarkdownParser.new markdown
      data = parser.execute
      expect(data.metadata).to eq({key: "value"})
    end
  end

  context "markdown with wrong parameter" do
    let(:markdown) { Struct.new(:some_attribute) }

    it "should throw an execption" do
      parser = MarkdownParser.new markdown
      expect{ parser.execute }.to raise_error(RuntimeError)
    end
  end
end
