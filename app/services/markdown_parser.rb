require 'metadown'

# Public: MarkdownParser parse metadata and html from markdown
class MarkdownParser

  # Public: Initialize the MarkdownParser class
  #
  # markdown - A string which contains a yaml header and
  #            markdown content
  def initialize(markdown)
    @markdown = markdown
  end

  # Public: Renders markdown to metadata and html
  #
  # Returns an object with html and metadata as attributes
  def execute
    begin
      data = Metadown.render(@markdown)

      # convert string keys to symbols
      data.metadata = Hash[data.metadata.map{ |k, v| [k.to_sym, v] }]

      data
    rescue => e
      raise "Can't parse markdown! #{ e.message }"
    end
  end
end
